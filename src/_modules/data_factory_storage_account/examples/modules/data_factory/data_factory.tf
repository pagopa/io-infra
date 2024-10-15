resource "azurerm_data_factory" "data_factory" {
  for_each            = var.data_factories
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${local.azure_data_factory}-${each.value.name}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  identity {
    type = "SystemAssigned"
  }
}