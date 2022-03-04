#
# Storage Accounts
#
data "azurerm_storage_account" "api" {
  name                = "iopstapi"
  resource_group_name = azurerm_resource_group.rg_internal.name
}

# CDN Assets storage account
data "azurerm_storage_account" "cdnassets" {
  name                = "iopstcdnassets"
  resource_group_name = var.common_rg
}
