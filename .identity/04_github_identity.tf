resource "azurerm_resource_group" "identity_rg" {
  name     = "${local.project}-identity-rg"
  location = var.location

  tags = var.tags
}

module "identity_ci" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.34.0"

  prefix    = var.prefix
  env_short = var.env_short

  identity_role = "ci"

  github_federations = var.ci_github_federations

  ci_rbac_roles = {
    subscription_roles = var.environment_ci_roles.subscription
    resource_groups    = var.environment_ci_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.identity_rg
  ]
}

module "identity_cd" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.34.0"

  prefix    = var.prefix
  env_short = var.env_short

  identity_role = "cd"

  github_federations = var.cd_github_federations

  cd_rbac_roles = {
    subscription_roles = var.environment_cd_roles.subscription
    resource_groups    = var.environment_cd_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.identity_rg
  ]
}
