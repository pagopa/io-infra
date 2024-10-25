resource "azurerm_role_definition" "pagopa_opex_contributor" {
  name        = "PagoPA Opex Contributor"
  scope       = var.subscription_id
  description = "Role to manage the Opex Dashboards creation, modification and deletion"

  permissions {
    actions = [
      "Microsoft.Portal/dashboards/write",
      "Microsoft.Portal/dashboards/read",
      "Microsoft.Portal/dashboards/delete",
      "Microsoft.Portal/dashboards/sharedDashboard/principalAssignments/write",
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}"
  ]
}
