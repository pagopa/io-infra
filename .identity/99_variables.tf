variable "tags" {
  type = map(any)
  default = {
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra"
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  }
}

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
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

variable "github_repository_environment_ci" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
  })
  description = "GitHub Continous Integration roles"
}

variable "github_repository_environment_cd" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
    reviewers_teams        = list(string)
  })
  description = "GitHub Continous Integration roles"
}

variable "ci_github_federations" {
  type = list(object({
    repository        = string
    credentials_scope = optional(string, "environment")
    subject           = string
  }))
  description = "GitHub Organization, repository name and scope permissions"
}

variable "cd_github_federations" {
  type = list(object({
    repository        = string
    credentials_scope = optional(string, "environment")
    subject           = string
  }))
  description = "GitHub Organization, repository name and scope permissions"
}

variable "environment_ci_roles" {
  type = object({
    subscription    = list(string)
    resource_groups = map(list(string))
  })
  description = "GitHub Continous Integration roles"
}

variable "environment_cd_roles" {
  type = object({
    subscription    = list(string)
    resource_groups = map(list(string))
  })
  description = "GitHub Continous Delivery roles"
}
