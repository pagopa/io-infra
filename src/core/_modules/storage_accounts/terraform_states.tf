# At the moment the storage account must have public access enabled due to many github runners not using private agents,
# also a private endpoint for the storage is still not implemented.

#trivy:ignore:AZU-0012
resource "azurerm_storage_account" "terraform_state_itn" {

  name                = replace("${var.project}tfst001", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "ZRS"

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}
