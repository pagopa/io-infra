resource "azurerm_storage_account" "retirements_itn_01" {
  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}retirementsst01", "-", "")
  resource_group_name      = var.resource_group_common
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"

  public_network_access_enabled    = true
  allow_nested_items_to_be_public  = false
  shared_access_key_enabled        = false
  default_to_oauth_authentication  = true
  cross_tenant_replication_enabled = false

  tags = var.tags
}
