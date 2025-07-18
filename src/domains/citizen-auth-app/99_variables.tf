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

variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) <= 12
    )
    error_message = "Max length is 12 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}

variable "location_string" {
  type        = string
  description = "One of West Europe, North Europe"
}

variable "instance" {
  type        = string
  description = "One of prod01, prod02"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "lollipop_enabled" {
  type        = bool
  default     = false
  description = "Lollipop function enabled?"
}

### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}

variable "application_insights_name" {
  type        = string
  description = "Specifies the name of the Application Insights."
}

# Function LolliPOP

variable "cidr_subnet_fnlollipop" {
  type        = list(string)
  description = "Function Lollipop address space."
}

variable "cidr_subnet_fnlollipop_itn" {
  type        = list(string)
  description = "Function Lollipop address space."
}

variable "function_lollipop_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_lollipop_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_lollipop_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 3
}

variable "function_lollipop_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 10
}

variable "function_lollipop_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 3
}

####################
# Session manager ##
####################
variable "cidr_subnet_session_manager" {
  type        = list(string)
  description = "Session manager app service address space."
}

variable "session_manager_plan_sku_name" {
  description = "App service plan sku name"
  type        = string
  default     = "P1v3"
}

####################

# DNS
variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_io" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

################################
# Shared plan
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
  default     = 3
}
###########################
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
##################################
