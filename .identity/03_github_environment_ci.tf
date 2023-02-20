resource "github_repository_environment" "github_repository_environment_ci" {
  environment = "${var.env}-ci"
  repository  = var.github.repository
  deployment_branch_policy {
    protected_branches     = var.github_repository_environment_ci.protected_branches
    custom_branch_policies = var.github_repository_environment_ci.custom_branch_policies
  }
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_tenant_id" {
  repository      = var.github.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_subscription_id" {
  repository      = var.github.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_client_id" {
  repository      = var.github.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_service_principal.environment_ci.application_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_container_app_environment_name" {
  repository      = var.github.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_CONTAINER_APP_ENVIRONMENT_NAME"
  plaintext_value = "${local.project}-github-runner-cae"
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_resource_group_name" {
  repository      = var.github.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_RESOURCE_GROUP_NAME"
  plaintext_value = "${local.project}-github-runner-rg"
}
