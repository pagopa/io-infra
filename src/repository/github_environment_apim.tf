resource "github_repository_environment" "github_repository_environment_apim_prod" {
  environment = "prod-apim"
  repository  = github_repository.this.name

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }

  reviewers {
    teams = matchkeys(
      data.github_organization_teams.all.teams[*].id,
      data.github_organization_teams.all.teams[*].slug,
      local.apim_prod.reviewers_teams
    )
  }
}

resource "github_actions_environment_secret" "env_apim_prod_secrets" {
  for_each = local.apim_prod.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.github_repository_environment_apim_prod.environment
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_repository_environment_deployment_policy" "apim_prod_branch" {
  repository     = github_repository.this.name
  environment    = github_repository_environment.github_repository_environment_apim_prod.environment
  branch_pattern = "apim-backup-restore-workflow"
}
