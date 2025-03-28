resource "github_repository_environment" "github_repository_environment_prod_ci" {
  environment = "prod-ci"
  repository  = github_repository.this.name

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_environment" "github_repository_environment_dev_ci" {
  environment = "dev-ci"
  repository  = github_repository.this.name

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_actions_environment_secret" "env_prod_ci_secrets" {
  for_each = local.prod_ci.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.github_repository_environment_prod_ci.environment
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_environment_secret" "env_dev_ci_secrets" {
  for_each = local.dev_ci.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.github_repository_environment_dev_ci.environment
  secret_name     = each.key
  plaintext_value = each.value
}
