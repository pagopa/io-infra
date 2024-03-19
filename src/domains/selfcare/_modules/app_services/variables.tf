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
  description = "Subnet Id for the App Services and Function Apps"
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

variable "apim_hostname_api_app_internal" {
  type        = string
  description = "Admin API url to save in app configs"
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "Id of the subnet which has private endpoints"
}

variable "app_insights_ips" {
  type        = list(string)
  description = "List of Application Insights IPs"
}

variable "db_server_data" {
  type = object({
    username = string
    password = string
  })

  sensitive   = true
  description = "Database credentials to save in app configs"
}
