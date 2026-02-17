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

variable "location_itn" {
  type    = string
  default = "italynorth"
}

variable "project_itn" {
  type = string
}

variable "project" {
  type = string
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "vnet_common_name_itn" {
  type        = string
  description = "name of the common itn vnet"
}

variable "common_resource_group_name_itn" {
  type        = string
  description = "name of the common itn resource group"
}

variable "continua_snet_cidr" {
  type        = string
  description = "Services Subnet CIDR"
}