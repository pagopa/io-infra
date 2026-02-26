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

variable "location_itn" {
  type    = string
  default = "italynorth"
}

variable "project_itn" {
  type = string
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

variable "vnet_common_name_itn" {
  type        = string
  description = "name of the common itn vnet"
}

variable "common_resource_group_name_itn" {
  type        = string
  description = "name of the common itn resource group"
}

variable "function_admin_locked_profiles_table_name" {
  type        = string
  description = "Locked profiles table name"
  default     = "lockedprofile01"
}

variable "apim_hostname_api_internal" {
  type        = string
  description = "hostname api"
  default     = "api-internal.io.italia.it"
}

variable "message_content_container_name" {
  type        = string
  description = "message content container name"
  default     = "message-content"
}

variable "service_api_url" {
  type        = string
  description = "url service api"
  default     = "https://api-app.internal.io.pagopa.it/"
}

variable "admin_snet_cidr" {
  type        = string
  description = "Admin Subnet CIDR"
}

#
# Autoscaler
#

variable "function_admin_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 3
}

variable "function_admin_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_admin_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 3
}