locals {
  backoffice_func_settings = merge({
    COSMOS_DB_CONNECTION_STRING = module.cosmosdb_account.connection_strings[0],
    COSMOS_DB_NAME              = module.cosmosdb_sql_database_backoffice.name
    }, {
    for s in var.io_sign_backoffice_func.app_settings :
    s.name => s.key_vault_secret_name != null ? "@Microsoft.KeyVault(VaultName=${module.key_vault.name};SecretName=${s.key_vault_secret_name})" : s.value
  })
  io_sign_backoffice_func = {
    staging_disabled = ["onSelfcareContractsMessage"]
  }
}

module "io_sign_backoffice_func" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.46.0"

  name                = format("%s-backoffice-func", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  health_check_path = "/health"

  node_version    = "18"
  runtime_version = "~4"
  always_on       = true

  app_settings = local.backoffice_func_settings

  subnet_id = module.io_sign_backoffice_snet.id

  sticky_app_setting_names = [
    for to_disable in local.io_sign_backoffice_func.staging_disabled :
    format("AzureWebJobs.%s.Disabled", to_disable)
  ]

  allowed_subnets = [
    module.io_sign_snet.id
  ]

  app_service_plan_id = module.io_sign_backoffice_app.plan_id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  system_identity_enabled                  = true

  tags = var.tags
}

resource "azurerm_private_endpoint" "io_sign_backoffice_func" {
  name                = format("%s-backoffice-func-endpoint", local.project)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-backoffice-endpoint", local.project)
    private_connection_resource_id = module.io_sign_backoffice_func.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "backoffice_func_key_vault_access_policy" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.io_sign_backoffice_func.system_identity_principal

  secret_permissions      = ["Get"]
  storage_permissions     = []
  certificate_permissions = []
}

module "io_sign_backoffice_func_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v7.46.0"

  name                = "staging"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  function_app_id     = module.io_sign_backoffice_func.id
  app_service_plan_id = module.io_sign_backoffice_func.app_service_plan_id

  health_check_path = "/health"

  storage_account_name       = module.io_sign_backoffice_func.storage_account.name
  storage_account_access_key = module.io_sign_backoffice_func.storage_account.primary_access_key

  node_version                             = "18"
  runtime_version                          = "~4"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.backoffice_func_settings,
    {
      # Disabled functions on slot triggered by queue and timer
      for to_disable in local.io_sign_backoffice_func.staging_disabled :
      format("AzureWebJobs.%s.Disabled", to_disable) => "true"
    }
  )

  subnet_id = module.io_sign_backoffice_snet.id

  allowed_subnets = [
    module.io_sign_snet.id
  ]

  tags = var.tags
}
