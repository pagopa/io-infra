variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "prefix" {
  type        = string
  description = "Prefix for resources"
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
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "location_short" {
  type        = string
  description = "Azure region short name"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VNet"
}

variable "subscription_current" {
  description = "Current subscription information"
}

## VPN ##
variable "vnet_common" {
  type = object({
    id                  = string
    name                = string
    address_space       = list(string)
    resource_group_name = string
  })
  description = "Information of the common VNet"
}

variable "vpn_sku" {
  type        = string
  default     = "VpnGw1AZ"
  description = "VPN Gateway SKU"
}

variable "vpn_pip_sku" {
  type        = string
  default     = "Standard"
  description = "VPN GW PIP SKU"
}

variable "vpn_cidr_subnet" {
  type        = list(string)
  description = "VPN network address space."
}

variable "dnsforwarder_cidr_subnet" {
  type        = list(string)
  description = "DNS Forwarder network address space."
}
