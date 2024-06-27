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

# variable "env_short" {
#   type = string
#   validation {
#     condition = (
#       length(var.env_short) <= 1
#     )
#     error_message = "Max length is 1 chars."
#   }
# }

variable "location" {
  type    = string
  default = "westeurope"
}

variable "location_in" {
  type    = string
  default = "italynorth"
}

# variable "location_short" {
#   type = string
#   validation {
#     condition = (
#       length(var.location_short) == 3
#     )
#     error_message = "Length must be 3 chars."
#   }
#   description = "One of weu, neu"
# }

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
# Function Admin
################################

# variable "cidr_subnet_fnadmin
#   type        = list(string)
#   description = "Function Admin address space."
# }

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
