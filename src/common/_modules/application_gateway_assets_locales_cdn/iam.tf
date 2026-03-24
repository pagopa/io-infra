resource "azurerm_user_assigned_identity" "agw" {
  resource_group_name = var.resource_group_common
  location            = var.location
  name                = "${var.project}-assets-agw-id-01"

  tags = var.tags
}

module "agw_kv_rbac" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.1"

  subscription_id = var.subscription_id
  principal_id    = azurerm_user_assigned_identity.agw.principal_id

  key_vault = [
    {
      name                = var.custom_domains_certificate_kv_name
      resource_group_name = var.custom_domains_certificate_kv_rg
      has_rbac_support    = true
      description         = "Allow Application Gateway identity to read certificates for the custom domains"
      roles = {
        certificates = "reader"
      }
    }
  ]
}