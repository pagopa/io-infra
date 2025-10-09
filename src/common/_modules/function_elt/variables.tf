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

variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "secondary_location_display_name" {
  type        = string
  description = "Azure redundancy region display name"
}

variable "location_itn" {
  type    = string
  default = "italynorth"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where resources will be created"
}

variable "vnet_name" {
  type        = string
  description = "VNet name"
}

variable "vnet_common_name_itn" {
  type = string
}

variable "common_resource_group_name_itn" {
  type = string
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet to use for Function App"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name used to handle errors"
}

variable "storage_account_primary_access_key" {
  type        = string
  sensitive   = true
  description = "Storage account primary access key used to handle errors"
}

variable "storage_account_primary_connection_string" {
  type        = string
  sensitive   = true
  description = "Storage account primary connection string used to handle errors"
}

variable "storage_account_itn_primary_connection_string" {
  type      = string
  sensitive = true
}

variable "storage_account_tables" {
  type = object({
    fnelterrors                     = string
    fnelterrors_messages            = string
    fnelterrors_message_status      = string
    fnelterrors_notification_status = string
    fneltcommands                   = string
    fneltexports                    = string
  })
}

variable "storage_account_containers" {
  type = object({
    container_messages_report_step1      = string
    container_messages_report_step_final = string
  })
}

variable "elt_snet_cidr" {
  type        = string
  description = "ELT Services Subnet CIDR"
}