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

variable "azure_ad_group_admin_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_ad_group_developers_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription developers"
}

variable "io_infra_ci_managed_identity_principal_id" {
  type        = string
  description = ""
}

variable "io_infra_cd_managed_identity_principal_id" {
  type        = string
  description = ""
}

variable "platform_iac_sp_object_id" {
  type = string
}
