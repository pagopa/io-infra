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

variable "resource_group_name" {
  type        = string
  description = "Resource group where create resources"
}

variable "resource_group_itn" {
  type        = string
  description = "Resource group where create common resources in Italy North"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_common" {
  type        = string
  description = "Name of common resource group"
  default     = null
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant id"
}

variable "admins" {
  type        = set(string)
  description = "List of Azure AD group object IDs for Key Vault admins"
}

variable "devs" {
  type        = set(string)
  description = "List of Azure AD group object IDs for Key Vault developers"
}

variable "ci" {
  type        = set(string)
  description = "List of Managed Identity principal IDs for CI"
}

variable "cd" {
  type        = set(string)
  description = "List of Managed Identity principal IDs for CD"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "subnet_pep_id" {
  type        = string
  description = "Subnet ID for Private Endpoint"
}

variable "private_dns_zone_id" {
  type        = string
  description = "ID of the Private DNS Zone for Key Vault"
}

variable "platform_iac_sp_object_id" {
  type = string
}
