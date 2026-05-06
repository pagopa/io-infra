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
  type    = string
  default = "p"
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_cdn" {
  type        = string
  description = "CDN resource group name"
}

variable "resource_group_external" {
  type        = string
  description = "External resource group name"
}

variable "public_dns_zones" {
  type        = map(any)
  description = "Public dns zones information"
}
