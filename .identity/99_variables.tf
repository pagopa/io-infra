variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "github" {
  type = object({
    org        = string
    repository = string
  })
  description = "GitHub Organization and repository name"
  default = {
    org        = "pagopa"
    repository = "io-infra"
  }
}

variable "github_token" {
  type        = string
  sensitive   = true
  description = "GitHub Organization and repository name"
}

variable "environment_ci_roles" {
  type = object({
    subscription = list(string)
  })
  description = "GitHub Continous Integration roles"
}

variable "github_repository_environment_ci" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
  })
  description = "GitHub Continous Integration roles"
}

variable "environment_cd_roles" {
  type = object({
    subscription = list(string)
  })
  description = "GitHub Continous Delivery roles"
}

variable "github_repository_environment_cd" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
    reviewers_teams        = list(string)
  })
  description = "GitHub Continous Integration roles"
}
