resource "azurerm_resource_group" "elt_rg" {
  name     = format("%s-elt-rg", local.project)
  location = var.location

  tags = var.tags
}

module "fnelt_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.60"
  name                 = "fn3elt"
  address_prefixes     = var.cidr_subnet_fnelt
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  service_endpoints    = ["Microsoft.EventHub"]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "fnelt" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=IP-431--function_app_refinement"

  resource_group_name                      = azurerm_resource_group.elt_rg.name
  global_prefix                            = var.prefix
  environment_short                        = var.env_short
  name                                     = "elt"
  location                                 = var.location
  health_check_path                        = "api/v1/info"
  subnet_id                                = module.fnelt_snet.id
  runtime_version                          = "~3"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  resources_prefix = {
    function_app     = "fn3"
    app_service_plan = "fn3"
    storage_account  = "fn3"
  }

  app_service_plan_info = {
    kind     = "elastic"
    sku_tier = "ElasticPremium"
    sku_size = "EP1"
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    NODE_ENV                       = "production"

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    APPINSIGHTS_SAMPLING_PERCENTAGE = 5
  }

  allowed_subnets = []

  allowed_ips = []

  tags = var.tags
}

module "storage_account_durable_function" {

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.60"

  name                     = format("%s%sstfd%s", var.prefix, var.env_short, "elt")
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  access_tier              = "Hot"
  resource_group_name      = azurerm_resource_group.elt_rg.name
  location                 = var.location

  network_rules = {
    default_action = "Deny"
    ip_rules       = []
    bypass = [
      "Logging",
      "Metrics",
      "AzureServices",
    ]
    virtual_network_subnet_ids = [
      module.fnelt_snet.id
    ]
  }

  tags = var.tags
}
