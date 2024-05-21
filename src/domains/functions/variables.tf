################################
# General variables
################################

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

variable "location_in" {
  type    = string
  default = "italynorth"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of weu, neu"
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

################################
# Function Assets CDN
################################

variable "cidr_subnet_fncdnassets" {
  type        = list(string)
  description = "Fn assets address space."
}

variable "function_assets_cdn_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_assets_cdn_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_assets_cdn_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_assets_cdn_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_assets_cdn_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_assets_cdn_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

################################
# Function Public
################################

variable "function_public_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_public_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_public_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

################################
# Function Services
################################

variable "cidr_subnet_services" {
  type        = list(string)
  description = "Function services address space."
}

variable "function_services_count" {
  type    = number
  default = 2
}

variable "function_services_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_services_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_services_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_services_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_services_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_services_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "function_services_subscription_cidrs_max_thoughput" {
  type    = number
  default = 1000
}

variable "pn_service_id" {
  type        = string
  description = "The Service ID of PN service"
  default     = "01G40DWQGKY5GRWSNM4303VNRP"
}

################################
# Function Shared
################################

variable "cidr_subnet_shared_1" {
  type = list(string)
}

variable "plan_shared_1_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "plan_shared_1_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "plan_shared_1_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "plan_shared_1_sku_capacity" {
  description = "Shared functions app plan capacity"
  type        = number
  default     = 1
}

################################
# Function App
################################

variable "cidr_subnet_app" {
  type        = list(string)
  description = "Function app address space."
}

variable "function_app_count" {
  type    = number
  default = 2
}

variable "function_app_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_app_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_app_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_app_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_app_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_app_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

################################
# Function App Async
################################

variable "cidr_subnet_app_async" {
  type        = list(string)
  description = "Function app async address space."
}

variable "function_app_async_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_app_async_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_app_async_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_app_async_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_app_async_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_app_async_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

################################
# Function Admin
################################

variable "cidr_subnet_fnadmin" {
  type        = list(string)
  description = "Function Admin address space."
}

variable "function_admin_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_admin_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_admin_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_admin_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_admin_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_admin_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "function_admin_locked_profiles_table_name" {
  type        = string
  description = "Locked profiles table name"
  default     = "lockedprofiles"
}
