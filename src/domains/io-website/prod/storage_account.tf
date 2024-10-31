resource "azurerm_storage_account" "website" {
  name                = replace("${local.project}stcdniowebsite", "-", "")
  resource_group_name = "${local.project}-rg-common"
}
