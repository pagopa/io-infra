variable "source_vnet" {
  type = object({
    name                         = string
    id                           = string
    resource_group_name          = string
    allow_gateway_transit        = optional(bool, false)
    allow_virtual_network_access = optional(bool, true)
    allow_forwarded_traffic      = optional(bool, false)
  })

  description = "The source vnet information"
}

variable "target_vnets" {
  type = map(object({
    name                = string
    id                  = string
    resource_group_name = string
    use_remote_gateways = optional(bool, false)
    symmetrical = optional(object({
      enabled               = optional(bool, false)
      use_remote_gateways   = optional(bool, false)
      allow_gateway_transit = optional(bool, false)
      }), {
      enabled               = false
      use_remote_gateways   = false
      allow_gateway_transit = false
    })
  }))

  description = "The destination vnets information"
}
