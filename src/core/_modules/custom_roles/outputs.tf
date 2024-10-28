output "pagopa_opex_contributor" {
  value = {
    id   = azurerm_role_definition.pagopa_opex_contributor.id
    name = azurerm_role_definition.pagopa_opex_contributor.name
  }
}
