module "resource_groups" {
  source = "../../_modules/resource_groups"

  location = local.location
  project  = local.project

  tags = local.tags
}

locals {
  rg_ids = {
    "be" = module.resource_groups.resource_group_selfcare_be.id
  }
}

resource "azurerm_role_assignment" "admins_group_rg" {
  for_each = local.rg_ids

  scope                = each.value
  role_definition_name = "Owner"
  principal_id         = data.azuread_group.svc_admins.object_id
  description          = "Allow AD Admin group the complete ownership at resource group scope"
}

resource "azurerm_role_assignment" "devs_group_rg" {
  for_each = local.rg_ids

  scope                = each.value
  role_definition_name = "Contributor"
  principal_id         = data.azuread_group.svc_devs.object_id
  description          = "Allow AD Dev group to apply changes at resource group scope"
}