variable "location" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "project" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "frontend_hostname" {
  type = string
}

variable "backend_hostname" {
  type = string
}

variable "selfcare_external_hostname" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "apim_hostname_api_app_internal" {
  type = string
}
