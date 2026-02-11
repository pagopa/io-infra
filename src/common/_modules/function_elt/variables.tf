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

variable "project_weu_legacy" {
  type        = string
  description = "IO prefix and short environment"
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

variable "vnet_common_name_itn" {
  type = string
}

variable "common_resource_group_name_itn" {
  type = string
}


variable "elt_snet_cidr" {
  type        = string
  description = "ELT Services Subnet CIDR"
}