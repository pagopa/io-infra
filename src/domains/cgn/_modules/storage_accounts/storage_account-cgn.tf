module "storage_account_cgn" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.64.0"

  name                = "${replace(var.project, "-", "")}stcgn"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GRS"
  public_network_access_enabled = true

  tags = var.tags
}
