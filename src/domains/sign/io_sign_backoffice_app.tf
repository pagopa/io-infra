module "io_sign_backoffice_app" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v6.20.2"

  name                = format("%s-backoffice-app", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  plan_name = format("%-backoffice-service-plan")
  sku_name  = var.io_sign_backoffice_app.sku_name

  docker_image = "ghcr.io/pagopa/io-sign-backoffice"

  app_settings = [
    for s in var.io_sign_backoffice_app.app_settings : s.key_vault_secret_name != null ?
    "@Microsoft.KeyVault(VaultName=${module.key_vault.name};SecretName=${s.key_vault_secret_name}" :
    s.value
  ]

  always_on        = true
  vnet_integration = true

  subnet_id = module.io_sign_snet.id

  allowed_subnets = [
    module.io_sign_snet.id,
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
