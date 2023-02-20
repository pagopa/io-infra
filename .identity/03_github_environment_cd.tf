resource "github_repository_environment" "github_repository_environment_cd" {
  environment = "${var.env}-cd"
  repository  = var.github.repository
  # filter teams reviewers from github_organization_teams
  # if reviewers_teams is null no reviewers will be configured for environment
  dynamic "reviewers" {
    for_each = (var.github_repository_environment_cd.reviewers_teams == null ? [] : [1])
    content {
      teams = matchkeys(
        data.github_organization_teams.all.teams.*.id,
        data.github_organization_teams.all.teams.*.name,
        var.github_repository_environment_cd.reviewers_teams
      )
    }
  }
  deployment_branch_policy {
    protected_branches     = var.github_repository_environment_cd.protected_branches
    custom_branch_policies = var.github_repository_environment_cd.custom_branch_policies
  }
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_tenant_id" {
  repository      = var.github.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_subscription_id" {
  repository      = var.github.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_client_id" {
  repository      = var.github.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_service_principal.environment_cd.application_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_container_app_environment_name" {
  repository      = var.github.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_CONTAINER_APP_ENVIRONMENT_NAME"
  plaintext_value = "${local.project}-github-runner-cae"
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_cd_resource_group_name" {
  repository      = var.github.repository
  environment     = "${var.env}-cd"
  secret_name     = "AZURE_RESOURCE_GROUP_NAME"
  plaintext_value = "${local.project}-github-runner-rg"
}
