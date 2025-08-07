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

variable "pn_service_id" {
  type        = string
  description = "The Service ID of PN service"
  default     = "01G40DWQGKY5GRWSNM4303VNRP"
}

variable "vnet_common_name_itn" {
  type        = string
  description = "name of the common itn vnet"
}

variable "common_resource_group_name_itn" {
  type        = string
  description = "name of the common itn resource group"
}

variable "opt_out_email_switch_date" {
  type        = number
  description = "Switch limit date for email opt out mode. This value should be used by functions that need to discriminate how to check isInboxEnabled property on IO profiles, since we have to disable email notifications for default for all profiles that have been updated before this date. This date should coincide with new IO App's release date 1625781600 value refers to 2021-07-09T00:00:00 GMT+02:00"
  default     = 1625781600
}

variable "ff_opt_in_email_enabled" {
  type        = string
  description = "Feature flag used to enable email opt-in with logic exposed by the previous variable usage"
  default     = "true"
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

variable "services_snet" {
  type = object({
    id   = string
    name = string
  })
  description = "Subnet"
}
