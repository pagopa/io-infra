locals {
  backoffice_app_settings = merge({
    AZURE_SUBSCRIPTION_ID          = data.azurerm_subscription.current.subscription_id
    COSMOS_DB_CONNECTION_STRING    = module.cosmosdb_account.connection_strings[0],
    COSMOS_DB_NAME                 = module.cosmosdb_sql_database_backoffice.name
    COSMOS_CONTAINER_NAME       = module.cosmosdb_sql_container_backoffice-api-keys.name
    APIM_RESOURCE_GROUP_NAME       = "io-p-rg-internal",
    APIM_SERVICE_NAME              = "io-p-apim-api"
    APIM_PRODUCT_NAME              = module.apim_io_sign_product.product_id
    APPINSIGHTS_INSTRUMENTATIONKEY = sensitive(data.azurerm_application_insights.application_insights.instrumentation_key)
    },
    {
      for s in var.io_sign_backoffice_app.app_settings :
      s.name => s.key_vault_secret_name != null ? "@Microsoft.KeyVault(VaultName=${module.key_vault.name};SecretName=${s.key_vault_secret_name})" : s.value
  })
}

module "io_sign_backoffice_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.20.2"
  name                 = format("%s-backoffice-snet", local.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.subnets_cidrs.backoffice

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

data "azurerm_subnet" "appgateway_snet" {
  name                 = var.io_common.appgateway_snet_name
  virtual_network_name = var.io_common.vnet_common_name
  resource_group_name  = var.io_common.resource_group_name
}

module "io_sign_backoffice_app" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v6.20.2"

  name                = format("%s-backoffice-app", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  plan_name = format("%s-backoffice-plan", local.project)
  sku_name  = var.io_sign_backoffice_app.sku_name

  docker_image     = "ghcr.io/pagopa/io-sign-backoffice"
  docker_image_tag = "latest"

  health_check_path = "/health"

  app_settings = local.backoffice_app_settings

  always_on        = true
  vnet_integration = true

  subnet_id = module.io_sign_backoffice_snet.id

  allowed_subnets = [
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_v2.id
  ]

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "backoffice_key_vault_access_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.io_sign_backoffice_app.principal_id

  secret_permissions      = ["Get"]
  storage_permissions     = []
  certificate_permissions = []
}

resource "azurerm_private_endpoint" "io_sign_backoffice_app" {
  name                = format("%s-backoffice-endpoint", local.project)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-backoffice-endpoint", local.project)
    private_connection_resource_id = module.io_sign_backoffice_app.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}
