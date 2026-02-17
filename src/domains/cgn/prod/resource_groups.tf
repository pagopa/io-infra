module "resource_groups" {
  source = "../_modules/resource_groups"

  location = local.location
  project  = local.project

  tags = local.tags
}

resource "azurerm_role_assignment" "bonus_owner_cgn" {
  scope                = module.resource_groups.resource_group_cgn.id
  role_definition_name = "Owner"
  principal_id         = data.azuread_group.bonus_admins.object_id
}
