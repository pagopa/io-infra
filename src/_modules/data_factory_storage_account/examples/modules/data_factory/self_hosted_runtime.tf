resource "azurerm_data_factory_integration_runtime_self_hosted" "self_hosted_runtime" {
  for_each        = var.self_hosted_runtimes
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${each.value.name}"
  data_factory_id = azurerm_data_factory.data_factory[each.value.data_factory].id
}