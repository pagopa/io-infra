locals {
  backoffice_func_settings = {
    for s in var.io_sign_backoffice_func.app_settings :
    s.name => s.key_vault_secret_name != null ? "@Microsoft.KeyVault(VaultName=${module.key_vault.name};SecretName=${s.key_vault_secret_name})" : s.value
  }
}

module "io_sign_backoffice_func" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.2.1"

  name                = format("%s-backoffice-func", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  health_check_path = "/health"

  node_version    = "18"
  runtime_version = "~4"
  always_on       = true

  app_settings = local.backoffice_func_settings

  subnet_id = module.io_sign_backoffice_snet.id

  allowed_subnets = [
    module.io_sign_snet.id
  ]

  app_service_plan_id = module.io_sign_backoffice_app.plan_id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  system_identity_enabled                  = true

  tags = var.tags
}
