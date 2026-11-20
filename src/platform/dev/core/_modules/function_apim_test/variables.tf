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
  description = "Azure region of the Function App."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the Function App and its supporting resources."
}

variable "virtual_network" {
  type = object({
    id                  = string
    name                = string
    resource_group_name = string
  })
  description = "Virtual network used by the Function App."
}

variable "private_endpoint_subnet_name" {
  type        = string
  description = "Name of the existing private endpoint subnet in the virtual network."
}

variable "private_dns_zone_ids" {
  type = object({
    blob          = string
    file          = string
    queue         = string
    azurewebsites = string
  })
  description = "Private DNS zone IDs for the Function App and its Storage account."
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
  description = "Tags assigned to the Function App resources."
}
