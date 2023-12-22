variable "prefix" {
  type    = string
  default = "io"
  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
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

variable "location" {
  type    = string
  default = "westeurope"
}

variable "github_runner" {
  type = object({
    pat_secret_name   = string
    subnet_cidr_block = string
  })
}

variable "resource_group_common_name" {
  type = string
}

variable "key_vault_common_name" {
  type = string
}

variable "vnet_common_name" {
  type = string
}

variable "law_common_name" {
  type = string
}
