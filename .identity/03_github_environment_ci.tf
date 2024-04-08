resource "github_repository_environment" "github_repository_environment_ci" {
  environment = "${var.env}-ci"
  repository  = local.repository
  deployment_branch_policy {
    protected_branches     = var.github_repository_environment_ci.protected_branches
    custom_branch_policies = var.github_repository_environment_ci.custom_branch_policies
  }
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_tenant_id" {
  repository      = local.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

#tfsec:ignore:github-actions-no-plain-text-action-secrets # not real secret
resource "github_actions_environment_secret" "azure_ci_subscription_id" {
  repository      = local.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.current.subscription_id
}

resource "github_actions_environment_secret" "azure_client_id_ci" {
  repository      = local.repository
  environment     = "${var.env}-ci"
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = module.identity_ci.identity_client_id
}
