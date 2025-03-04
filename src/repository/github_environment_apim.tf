resource "github_repository_environment" "apim_start" {
  environment = "apim-migration-start"
  repository  = github_repository.this.name

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}

resource "github_repository_environment" "apim_end" {
  environment = "apim-migration-end"
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

resource "github_actions_environment_secret" "apim_start" {
  for_each = local.apim_prod.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.apim_start.environment
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_environment_secret" "apim_end" {
  for_each = local.apim_prod.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.apim_end.environment
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_repository_environment_deployment_policy" "apim_start_main" {
  repository     = github_repository.this.name
  environment    = github_repository_environment.apim_start.environment
  branch_pattern = "main"
}

resource "github_repository_environment_deployment_policy" "apim_end_main" {
  repository     = github_repository.this.name
  environment    = github_repository_environment.apim_end.environment
  branch_pattern = "main"
}
