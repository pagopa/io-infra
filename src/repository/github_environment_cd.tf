resource "github_repository_environment" "github_repository_environment_prod_cd" {
  environment = "prod-cd"
  repository  = github_repository.this.name

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }

  reviewers {
    teams = matchkeys(
      data.github_organization_teams.all.teams[*].id,
      data.github_organization_teams.all.teams[*].slug,
      local.prod_cd.reviewers_teams
    )
  }
}

resource "github_repository_environment" "github_repository_environment_dev_cd" {
  environment = "dev-cd"
  repository  = github_repository.this.name

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }

  reviewers {
    teams = matchkeys(
      data.github_organization_teams.all.teams[*].id,
      data.github_organization_teams.all.teams[*].slug,
      local.dev_cd.reviewers_teams
    )
  }
}

resource "github_actions_environment_secret" "env_prod_cd_secrets" {
  for_each = local.prod_cd.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.github_repository_environment_prod_cd.environment
  secret_name     = each.key
  plaintext_value = each.value
}

resource "github_actions_environment_secret" "env_dev_cd_secrets" {
  for_each = local.dev_cd.secrets

  repository      = github_repository.this.name
  environment     = github_repository_environment.github_repository_environment_dev_cd.environment
  secret_name     = each.key
  plaintext_value = each.value
}
