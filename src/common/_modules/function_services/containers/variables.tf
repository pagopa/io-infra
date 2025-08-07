variable "cosmos_db_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "legacy_project" {
  type = string
}

variable "function_services_subscription_cidrs_max_thoughput" {
  type    = number
  default = 1000
}
