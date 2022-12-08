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

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

# domain specific

variable "storage" {
  type = object({
    enable_versioning = bool
    delete_after_days = number
    replication_type  = string
  })
}

variable "cosmos" {
  type = object({
    zone_redundant = bool
  })
}

variable "io_sign_database_issuer" {
  type = map(
    object({
      max_throughput = number
      ttl            = number
    })
  )
}

variable "io_sign_database_user" {
  type = map(
    object({
      max_throughput = number
      ttl            = number
    })
  )
}

variable "io_sign_issuer_func" {
  type = object({
    sku_tier = string
    sku_size = string
  })
}

variable "io_sign_user_func" {
  type = object({
    sku_tier = string
    sku_size = string
  })
}
