resource "azuread_directory_role" "directory_readers" {
  display_name = "Directory Readers"
}

data "azurerm_storage_account" "tfstate_app" {
  name                = "tfapp${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}"
  resource_group_name = "terraform-state-rg"
}

data "azurerm_storage_account" "tfstate_inf" {
  name                = "tfinf${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}"
  resource_group_name = "terraform-state-rg"
}

data "azurerm_resource_group" "github_runner_rg" {
  name = "${local.project}-github-runner-rg"
}

data "github_organization_teams" "all" {
  root_teams_only = true
  summary_only    = true
}
