variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  type        = map(any)
  description = "Resources tags"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "admins" {
  type        = set(string)
  description = "List of Azure AD group object IDs for Key Vault admins"
}

variable "devs" {
  type        = set(string)
  description = "List of Azure AD group object IDs for Key Vault developers"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}
