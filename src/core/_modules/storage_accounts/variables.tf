variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where create resources"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "azure_adgroup_admin_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_platform_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_wallet_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_wallet_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_com_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_com_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_svc_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_svc_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_auth_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_auth_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_bonus_admins_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "azure_adgroup_bonus_devs_object_id" {
  type        = string
  description = "Object Id of the Entra group for subscription admins"
}

variable "messages_sp_object_id" {
  type        = string
  description = "Object Id of the Service Principal used by DevOps pipelines"
}
