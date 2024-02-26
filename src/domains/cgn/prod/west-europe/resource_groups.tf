# resource "azurerm_resource_group" "cgn_be_rg" {
#   name     = format("%s-cgn-be-rg", local.project)
#   location = local.location

#   tags = local.tags
# }

module "resource_groups" {
  source = "../../_modules/resource_groups"

  env_short = "p"
  location  = "westeurope"

  tags = local.tags
}
