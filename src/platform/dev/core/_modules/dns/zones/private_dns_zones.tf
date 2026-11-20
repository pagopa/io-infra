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

data "azurerm_resource_group" "common" {
  name = var.resource_groups.common
}

data "azurerm_private_dns_zone" "app_service" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "dx-d-itn-typescript-rg-01"
}

locals {
  function_storage_private_dns_zones = {
    for service in ["blob", "file", "queue"] :
    service => "privatelink.${service}.core.windows.net"
  }
}

resource "azurerm_private_dns_zone" "storage" {
  for_each = local.function_storage_private_dns_zones

  name                = each.value
  resource_group_name = var.resource_groups.common
  tags                = var.tags
}
