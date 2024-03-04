variable "project" {
  type = string
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type = map(any)
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "subnet_private_endpoints_id" {
  type = string
}

variable "cosmos_db" {
  type = object({
    endpoint    = string
    primary_key = string
  })

  sensitive = true
}

variable "function_cgn_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_cgn_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_cgn_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "cgn_storage_account_connection_string" {
  type      = string
  sensitive = true
}

variable "redis" {
  type = object({
    hostname           = string
    ssl_port           = string
    primary_access_key = string
  })

  sensitive = true
}
