resource "github_repository_environment" "github_repository_environment_runner" {
  environment = "${var.env}-runner"
  repository  = var.github.repository
  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_runner_tenant_id" {
  repository      = var.github.repository
  environment     = "${var.env}-runner"
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_runner_subscription_id" {
  repository      = var.github.repository
  environment     = "${var.env}-runner"
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_runner_client_id" {
  repository      = var.github.repository
  environment     = "${var.env}-runner"
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = azuread_service_principal.environment_runner.application_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_runner_container_app_environment_name" {
  repository      = var.github.repository
  environment     = "${var.env}-runner"
  secret_name     = "AZURE_CONTAINER_APP_ENVIRONMENT_NAME"
  plaintext_value = "${local.project}-github-runner-cae"
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_runner_resource_group_name" {
  repository      = var.github.repository
  environment     = "${var.env}-runner"
  secret_name     = "AZURE_RESOURCE_GROUP_NAME"
  plaintext_value = "${local.project}-github-runner-rg"
}
