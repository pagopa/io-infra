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

variable "resource_group_assets_cdn" {
  type        = string
  description = "Assets CDN resource group name"
}

variable "resource_group_external" {
  type        = string
  description = "External resource group name"
}

variable "resource_group_common" {
  type        = string
  description = "Common resource group name"
}

variable "dns_default_ttl_sec" {
  type        = number
  description = "Default TTL of DNS records"
}

variable "public_dns_zones" {
  type        = map(any)
  description = "Public dns zones information"
}

variable "external_domain" {
  type        = string
  description = "Domain for delegation"
}

variable "assets_cdn_fn" {
  type = object({
    name     = string
    hostname = string
  })
  description = "Name of the assets CDN function"
}

variable "key_vault_common" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault Common"
}