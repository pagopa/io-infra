variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for the App Services"
}

variable "subnet_id" {
  type        = string
  description = "Subnet Id for the App Services"
}

variable "frontend_hostname" {
  type        = string
  description = "Frontend hostname to save in app configs"
}

variable "backend_hostname" {
  type        = string
  description = "Backend hostname to save in app configs"
}

variable "selfcare_external_hostname" {
  type        = string
  description = "External hostname to save in app configs"
}

# variable "dns_zone_name" {
#   type = string
# }

variable "apim_hostname_api_app_internal" {
  type        = string
  description = "Admin API url to save in app configs"
}
