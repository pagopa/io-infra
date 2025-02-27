data "azurerm_user_assigned_identity" "identity_prod_ci" {
  name                = "${local.project}-infra-github-ci-identity"
  resource_group_name = local.identity_resource_group_name
}

data "azurerm_user_assigned_identity" "identity_dev_ci" {
  provider            = azurerm.dev-io
  name                = "${local.project_dev}-infra-github-ci-identity"
  resource_group_name = local.identity_resource_group_name_dev
}

data "azurerm_user_assigned_identity" "identity_prod_cd" {
  name                = "${local.project}-infra-github-cd-identity"
  resource_group_name = local.identity_resource_group_name
}

data "azurerm_user_assigned_identity" "identity_prod_apim" {
  name                = "${local.project}-itn-ioinfra-apimbackup-github-cd-id-01"
  resource_group_name = "${local.project}-itn-common-rg-01"
}

data "azurerm_user_assigned_identity" "identity_dev_cd" {
  provider            = azurerm.dev-io
  name                = "${local.project_dev}-infra-github-cd-identity"
  resource_group_name = local.identity_resource_group_name_dev
}

data "github_organization_teams" "all" {
  root_teams_only = true
  summary_only    = true
}
