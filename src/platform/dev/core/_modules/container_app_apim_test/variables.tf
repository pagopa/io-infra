variable "prefix" {
  type        = string
  description = "Project prefix used in resource names."
}

variable "env_short" {
  type        = string
  description = "Short environment name."
}

variable "location" {
  type        = string
  description = "Azure region of the Container App."
}

variable "app_name" {
  type        = string
  default     = "apimtest"
  description = "Application name used in DX resource naming."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the Container App and its Environment."
}

variable "virtual_network" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Virtual network used by the Container App Environment."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of the Log Analytics workspace for the Container App Environment."
}

variable "api_management" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "Existing API Management instance hosting the test API."
}

variable "api_application_display_name" {
  type        = string
  description = "Display name of the Entra application exposing the ApiRead role."
}

variable "tags" {
  type        = map(string)
  description = "Tags assigned to the Container App resources."
}
