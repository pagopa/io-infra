prefix    = "io"
env_short = "p"
env       = "prod"
location  = "westeurope"

github_repository_environment_ci = {
  protected_branches     = false
  custom_branch_policies = true
}

github_repository_environment_cd = {
  protected_branches     = true
  custom_branch_policies = false
  reviewers_teams = [
    "infrastructure-admins",
    "io-backend-admin",
    "io-backend-contributors",
  ]
}

ci_github_federations = [
  {
    repository = "io-infra"
    subject    = "prod-ci"
  }
]

cd_github_federations = [
  {
    repository = "io-infra"
    subject    = "prod-ci"
  }
]

environment_ci_roles = {
  subscription = [
    "Reader",
    "PagoPA IaC Reader",
    "Reader and Data Access",
    "Storage Blob Data Reader",
    "Storage File Data SMB Share Reader",
    "Storage Queue Data Reader",
    "Storage Table Data Reader",
    "Key Vault Reader",
    "DocumentDB Account Contributor",
    "API Management Service Contributor",
  ]
  resource_groups = {
    "terraform-state-rg" = [
      "Storage Blob Data Contributor"
    ]
  }
}

environment_cd_roles = {
  subscription = [
    "Contributor",
    "Storage Account Contributor",
    "Storage Blob Data Contributor",
    "Storage File Data SMB Share Contributor",
    "Storage Queue Data Contributor",
    "Storage Table Data Contributor",
    "Key Vault Contributor",
  ]
  resource_groups = {}
}
