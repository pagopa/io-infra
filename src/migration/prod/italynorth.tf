module "adf" {
  source = "../_modules/datafactory"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.github_runner.name

  tags = local.tags
}