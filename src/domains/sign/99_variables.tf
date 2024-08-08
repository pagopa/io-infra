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

variable "key_vault_common" {
  type = object({
    resource_group_name = string
    name                = string
    pat_secret_name     = string
  })
}

# DNS
variable "dns_ses_validation" {
  type = list(object({
    name   = string
    record = string
  }))
  description = "CNAME records to validate SES domain identity"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "Default TTL for DNS"
  default     = 3600
}

variable "dns_zone_names" {
  type = object({
    website = string
  })
  description = "The names for the DNS zones"
}

variable "subnets_cidrs" {
  type = map(
    list(string)
  )
  description = "The CIDR address prefixes of the subnets"
}

variable "storage_account" {
  type = object({
    enable_versioning             = bool
    change_feed_enabled           = bool
    delete_after_days             = number
    replication_type              = string
    enable_low_availability_alert = bool
  })
  description = "The configuration of the storage account storing documents"
}

variable "cosmos" {
  type = object({
    zone_redundant = bool
    additional_geo_locations = list(object({
      location          = string
      failover_priority = number
      zone_redundant    = bool
    }))
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

variable "io_sign_database_backoffice" {
  type = map(
    object({
      max_throughput = number
      ttl            = number
    })
  )
}

variable "io_sign_issuer_func" {
  type = object({
    sku_tier          = string
    sku_size          = string
    autoscale_default = number
    autoscale_minimum = number
    autoscale_maximum = number
  })
}

variable "io_sign_support_func" {
  type = object({
    sku_tier          = string
    sku_size          = string
    autoscale_default = number
    autoscale_minimum = number
    autoscale_maximum = number
  })
}


variable "io_sign_user_func" {
  type = object({
    sku_tier          = string
    sku_size          = string
    autoscale_default = number
    autoscale_minimum = number
    autoscale_maximum = number
  })
}

variable "integration_hub" {
  type = object({
    auto_inflate_enabled     = bool
    sku_name                 = string
    capacity                 = number
    maximum_throughput_units = number
    zone_redundant           = bool
    alerts_enabled           = bool
    ip_rules = list(object({
      ip_mask = string
      action  = string
    }))
    hubs = list(object({
      name              = string
      partitions        = number
      message_retention = number
      consumers         = list(string)
      keys = list(object({
        name   = string
        listen = bool
        send   = bool
        manage = bool
      }))
    }))
  })
  description = "The configuration, hubs and keys of the event hub relative to external integration"
}

variable "io_common" {
  type = object({
    resource_group_name          = string
    log_analytics_workspace_name = string
    appgateway_snet_name         = string
    vnet_common_name             = string
  })
  description = "Name of common resources of IO platform"
}

variable "io_sign_backoffice_app" {
  type = object({
    sku_name = string
    app_settings = list(object({
      name                  = string
      value                 = optional(string, "")
      key_vault_secret_name = optional(string)
    }))
  })
  description = "Configuration of the io-sign-backoffice app service"
}

variable "io_sign_backoffice_func" {
  type = object({
    autoscale_default = number
    autoscale_minimum = number
    autoscale_maximum = number
    app_settings = list(object({
      name                  = string
      value                 = optional(string, "")
      key_vault_secret_name = optional(string)
    }))
  })
  description = "Configuration of the io-sign-backoffice func app"
}
