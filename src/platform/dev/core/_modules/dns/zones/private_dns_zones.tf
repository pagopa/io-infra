resource "azurerm_private_dns_zone" "azure_api_net" {
  name                = "azure-api.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "management_azure_api_net" {
  name                = "management.azure-api.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}

resource "azurerm_private_dns_zone" "scm_azure_api_net" {
  name                = "scm.azure-api.net"
  resource_group_name = var.resource_groups.common

  tags = var.tags
}
