resource "azurerm_role_definition" "pagopa_opex_contributor" {
  name        = "PagoPA Opex Dashboards Contributor"
  scope       = var.subscription_id
  description = "Role to manage the Opex Dashboards creation, modification and deletion"

  permissions {
    actions = [
      "Microsoft.Portal/dashboards/write",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.Portal/dashboards/delete",
    ]
    not_actions = []
  }

  assignable_scopes = [
    var.subscription_id
  ]
}
