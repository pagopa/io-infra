variable "resource_group_common" {
  type        = string
  description = "Name of common resource group"
}

variable "resource_group_internal" {
  type        = string
  description = "Name of internal resource group"
}

variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

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

variable "vnet_common" {
  type = object({
    id                  = string
    name                = string
    address_space       = list(string)
    resource_group_name = string
  })
  description = "Information of the common VNet"
}

variable "cidr_subnet" {
  type        = string
  description = "APIM subnet CIDR block"
}

variable "action_group_id" {
  type = string
}

variable "ai_instrumentation_key" {
  type = string
}

variable "key_vault" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault"
}

variable "key_vault_common" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault Common"
}

variable "datasources" {
  type        = map(any)
  description = "Common datasources"
}

variable "migration" {
  type        = bool
  default     = false
  description = "Specify if it is a migration"
}

variable "azure_adgroup_wallet_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_com_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_svc_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_auth_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_bonus_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}
