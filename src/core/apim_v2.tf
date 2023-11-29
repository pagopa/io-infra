data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_certificate" "api_internal_io_italia_it" {
  name         = replace(local.apim_hostname_api_internal, ".", "-")
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_certificate" "api_app_internal_io_pagopa_it" {
  name         = replace(local.apim_hostname_api_app_internal, ".", "-")
  key_vault_id = module.key_vault.id
}

# APIM subnet
module "apim_v2_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.28.0"
  name                 = "apimv2api"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
  address_prefixes     = var.cidr_subnet_apim_v2

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}

resource "azurerm_network_security_group" "nsg_apim" {
  name                = format("%s-apim-v2-nsg", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
  location            = azurerm_resource_group.rg_common.location

  security_rule {
    name                       = "managementapim"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "snet_nsg" {
  subnet_id                 = module.apim_v2_snet.id
  network_security_group_id = azurerm_network_security_group.nsg_apim.id
}

resource "azurerm_public_ip" "public_ip_apim" {
  name                = format("%s-apim-v2-public-ip", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
  location            = azurerm_resource_group.rg_common.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "apimio"
  zones               = ["1", "2", "3"]

  tags = var.tags
}


# ###########################
# ## Api Management (apim) ##
# ###########################
module "apim_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v7.28.0"

  subnet_id                 = module.apim_v2_snet.id
  location                  = azurerm_resource_group.rg_internal.location
  name                      = format("%s-apim-v2-api", local.project)
  resource_group_name       = azurerm_resource_group.rg_internal.name
  publisher_name            = var.apim_publisher_name
  publisher_email           = data.azurerm_key_vault_secret.apim_publisher_email.value
  notification_sender_email = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                  = var.apim_v2_sku
  virtual_network_type      = "Internal"
  zones                     = ["1", "2"]

  public_ip_address_id = azurerm_public_ip.public_ip_apim.id

  # not used at the moment
  redis_connection_string = null # module.redis_apim.primary_connection_string
  redis_cache_id          = null # module.redis_apim.id

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  hostname_configuration = {
    proxy = [
      {
        # io-p-apim-api.azure-api.net
        default_ssl_binding = false
        host_name           = "io-p-apim-v2-api.azure-api.net"
        key_vault_id        = null
      },
      {
        # api-internal.io.italia.it
        default_ssl_binding = true
        host_name           = local.apim_hostname_api_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_internal_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_internal_io_italia_it.version}",
          ""
        )
      },
      {
        # api-app.internal.io.pagopa.it
        default_ssl_binding = false
        host_name           = local.apim_hostname_api_app_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.version}",
          ""
        )
      },
    ]
    developer_portal = null
    management       = null
    portal           = null
  }

  application_insights = {
    enabled             = true
    instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  }

  lock_enable = false # no lock

  autoscale = var.apim_autoscale

  alerts_enabled = var.apim_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/791642113/APIM+Capacity"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 60
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = var.tags
}

# ## api management key vault policy ##
resource "azurerm_key_vault_access_policy" "apim_v2_kv_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim_v2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "v2_common" {
  key_vault_id = module.key_vault_common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim_v2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

##################################################################
# PN APIM User
##################################################################
data "azurerm_api_management_product" "apim_v2_product_lollipop" {
  product_id          = "io-lollipop-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
}

data "azurerm_api_management_group" "api_v2_lollipop_assertion_read" {
  name                = "apilollipopassertionread"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
}

resource "azurerm_api_management_user" "pn_user_v2" {
  user_id             = "pnapimuser"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  first_name          = "PNAPIMuser"
  last_name           = "PNAPIMuser"
  email               = "pn-apim-user@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pn_user_group_v2" {
  user_id             = azurerm_api_management_user.pn_user_v2.user_id
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  group_name          = data.azurerm_api_management_group.api_v2_lollipop_assertion_read.name
}

resource "azurerm_api_management_subscription" "pn_lc_subscription_v2" {
  user_id             = azurerm_api_management_user.pn_user_v2.id
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_v2_product_lollipop.id
  display_name        = "PN LC"
  state               = "active"
  allow_tracing       = false
}
##################################################################
