variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
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

variable "servicebus_dns_zone" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Private link servicebus dns zone information"
}

variable "resource_group_common" {
  type        = string
  description = "Name of common resource group"
  default     = null
}

variable "vnet_common" {
  type = object({
    id                  = string
    name                = string
    address_space       = list(string)
    resource_group_name = string
  })
  description = "Information of the common VNet"
}

variable "key_vault" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault"
}

## Event hub
variable "cidr_subnet" {
  type        = list(string)
  description = "CIDR for the EventHub Namespace subnets."
}

variable "sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Standard"
}

variable "capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  default     = 5
}

variable "maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
  default     = 5
}

variable "auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = true
}

variable "zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = true
}

variable "eventhubs" {
  description = "A list of event hubs to add to namespace."
  type = list(object({
    name              = string
    partitions        = number
    message_retention = number
    consumers         = list(string)
    keys = list(object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))
  }))
  default = []
}

variable "ip_rules" {
  description = "eventhub network rules"
  type = list(object({
    ip_mask = string
    action  = string
  }))
  default = []
}

variable "alerts_enabled" {
  type        = bool
  default     = true
  description = "Event hub alerts enabled?"
}

variable "error_action_group_id" {
  type        = string
  description = "Azure Monitor error action group id"
}