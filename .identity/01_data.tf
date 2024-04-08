resource "azuread_directory_role" "directory_readers" {
  display_name = "Directory Readers"
}

data "github_organization_teams" "all" {
  root_teams_only = true
  summary_only    = true
}
