variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "dns" {
  description = "Global DNS configuration"

  type = object({
    resource_groups = map(string)
    vnets = map(object({
      id   = string
      name = string
    }))
    dns_default_ttl_sec = optional(number, 3600)
    external_domain     = optional(string, "pagopa.it")
    dns_zones = object({
      io                  = string
      firmaconio_selfcare = string
    })
    app_gateway_public_ip           = string
    apim_private_ip                 = string
    platform_api_gateway_private_ip = string
  })
}
