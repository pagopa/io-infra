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

variable "resource_groups" {
  type        = map(string)
  description = "Resource group names"
}

variable "vnets" {
  type = map(object({
    id                  = string
    name                = string
  }))
  description = "Map of virtual networks where to attach private dns zones"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zones" {
  type        = object({
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

# TODO: remove when apim v2 module is implemented
variable "apim_v2_public_ip" {
  type        = string
  description = "Public IP of the API Management v2"
}