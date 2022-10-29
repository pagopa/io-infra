# general

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 6 chars."
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

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) < 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "location" {
  type = string
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "terraform_remote_state_core" {
  type = object({
    resource_group_name  = string,
    storage_account_name = string,
    container_name       = string,
    key                  = string
  })
}

variable "storage" {
  type = object({
    enable_versioning            = bool
    delete_retention_policy_days = number
    replication_type             = string
  })
  default = {
    enable_versioning            = false
    delete_retention_policy_days = 15
    replication_type             = "ZRS"
  }
}

variable "io_sign_database" {
  type = object({
    throughput = number
  })
  default = {
    throughput = 800
  }
}

variable "io_sign_func" {
  type = object({
    sku_tier = string
    sku_size = string
  })
  default = {
    sku_tier = "Basic"
    sku_size = "B1"
  }
}
