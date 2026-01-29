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

variable "resource_group_linux" {
  type        = string
  description = "Linux resource group name"
}

variable "resource_group_internal" {
  type        = string
  description = "Internal resource group name"
}

variable "resource_group_common" {
  type        = string
  description = "Common resource group name"
}

variable "index" {
  type    = number
  default = 1
}

variable "name" {
  type        = string
  description = "Name of the backend (l1, l2, li, ...)"
  default     = null
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

variable "plan_sku" {
  description = "App backend app plan sku size"
  type        = string
  default     = "P1v3"
}

variable "allowed_subnets" {
  type = list(string)
}

variable "slot_allowed_subnets" {
  type = list(string)
}

variable "allowed_ips" {
  type = list(string)
}

variable "slot_allowed_ips" {
  type = list(string)
}

variable "cidr_subnet" {
  type        = list(string)
  description = "App backend address space"
}

variable "application_insights" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
    location            = string
    reserved_ips        = list(string)
  })
}

variable "ai_instrumentation_key" {
  type = string
}

variable "ai_connection_string" {
  type = string
}

variable "error_action_group_id" {
  type        = string
  description = "Azure Monitor error action group id"
}

variable "nat_gateways" {
  type = list(object({
    id                  = string
    name                = string
    resource_group_name = string
  }))
}

variable "key_vault_common" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault Common"
}

variable "key_vault" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Information of the Key Vault"
}

variable "datasources" {
  type        = map(any)
  description = "Common datasources"
}

variable "redis_common" {
  type = object({
    hostname           = string
    ssl_port           = number
    primary_access_key = string
  })
  description = "Connection information to the common redis cluster"
  sensitive   = true
}

variable "autoscale" {
  type = object({
    default = optional(number)
    minimum = optional(number)
    maximum = optional(number)
  })
  default     = null
  description = "Autoscale capacity information"
}

variable "citizen_auth_assertion_storage_name" {
  type        = string
  description = "Use storage name from citizen_auth domain"
  default     = "lollipop-assertions-st"
}

variable "app_settings_override" {
  type        = map(string)
  default     = {}
  description = "Map of values that override the common app settings stored in app_settings.tf"
}

variable "backend_hostnames" {
  type = object({
    app                  = list(string)
    com_citizen_func     = string
    assets_cdn           = string
    services_app_backend = string
    lollipop             = string
    cgn                  = string
    iosign               = string
    iofims               = string
    cgnonboarding        = string
    cdc_support          = string
  })
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

variable "enable_premium_plan_autoscale" {
  type        = bool
  description = "Enable autoscale for premium plan"
  default     = false
}

variable "subnet_pep_id" {
  type        = string
  description = "Subnet ID for the private endpoint"
}

variable "private_dns_zone_id" {
  type        = string
  description = "Private DNS Zone ID for the private endpoint"
}
