resource "github_repository_environment" "github_repository_environment_cd" {
  environment = "${var.env}-cd"
  repository  = local.repository
  # filter teams reviewers from github_organization_teams
  # if reviewers_teams is null no reviewers will be configured for environment
  dynamic "reviewers" {
    for_each = (var.github_repository_environment_cd.reviewers_teams == null ? [] : [1])
    content {
      teams = matchkeys(
        data.github_organization_teams.all.teams.*.id,
        data.github_organization_teams.all.teams.*.slug,
        var.github_repository_environment_cd.reviewers_teams
      )
    }
  }
  deployment_branch_policy {
    protected_branches     = var.github_repository_environment_cd.protected_branches
    custom_branch_policies = var.github_repository_environment_cd.custom_branch_policies
  }
}

# TODO: remove when all workflows read values from ARM_** secrets
#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_tenant_id_azure" {
  repository      = local.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

resource "github_actions_environment_secret" "azure_cd_tenant_id" {
  repository      = local.repository
  environment     = "${var.env}-cd"
  secret_name     = "ARM_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

# TODO: remove when all workflows read values from ARM_** secrets
#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_subscription_id_azure" {
  repository      = local.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}

resource "github_actions_environment_secret" "azure_cd_subscription_id" {
  repository      = local.repository
  environment     = "${var.env}-cd"
  secret_name     = "ARM_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}

# TODO: remove when all workflows read values from ARM_** secrets
resource "github_actions_environment_secret" "azure_client_id_cd_azure" {
  repository      = local.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = module.identity_cd.identity_client_id
}

resource "github_actions_environment_secret" "azure_client_id_cd" {
  repository      = local.repository
  environment     = "${var.env}-cd"
  secret_name     = "ARM_CLIENT_ID"
  plaintext_value = module.identity_cd.identity_client_id
}
