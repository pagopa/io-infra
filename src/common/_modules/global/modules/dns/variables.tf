variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_groups" {
  type        = map(string)
  description = "Resource group names"
}

variable "vnets" {
  type = map(object({
    id   = string
    name = string
  }))
  description = "Map of virtual networks where to attach private dns zones"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "Default TTL of DNS records"
  default     = 3600
}

variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zones" {
  type = object({
    io                  = string
    io_selfcare         = string
    firmaconio_selfcare = string
    }
  )
  description = "DNS zones to create"
}

# TODO: remove when app gateway module is implemented
variable "app_gateway_public_ip" {
  type        = string
  description = "Public IP of the app gateway"
}

variable "apim_private_ip" {
  type        = string
  description = "Private IP of the API Management"
}