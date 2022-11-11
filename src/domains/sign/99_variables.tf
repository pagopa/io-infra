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
    enable_versioning            = bool
    delete_retention_policy_days = number
    replication_type             = string
  })
  default = {
    enable_versioning            = false
    delete_retention_policy_days = 90
    replication_type             = "ZRS"
  }
}

variable "io_sign_database_issuer" {
  type = object({
    throughput = number
    dossiers = object({
      max_throughput = number
    })
    signature_requests = object({
      max_throughput = number
    })
    uploads = object({
      max_throughput = number
      ttl            = number
    })
  })
  default = {
    throughput = 800
    dossiers = {
      max_throughput = 4000
    }
    signature_requests = {
      max_throughput = 4000
    }
    uploads = {
      max_throughput = 4000
      ttl            = 7
    }
  }
}

variable "io_sign_database_user" {
  type = object({
    throughput = number
    signature_requests = object({
      max_throughput = number
    })
  })
  default = {
    throughput = 800
    signature_requests = {
      max_throughput = 4000
    }
  }
}

variable "io_sign_issuer_func" {
  type = object({
    version  = string
    sku_tier = string
    sku_size = string
  })
  default = {
    version  = null
    sku_tier = "Basic"
    sku_size = "B1"
  }
}

variable "io_sign_user_func" {
  type = object({
    version  = string
    sku_tier = string
    sku_size = string
  })
  default = {
    version  = null
    sku_tier = "Basic"
    sku_size = "B1"
  }
}
