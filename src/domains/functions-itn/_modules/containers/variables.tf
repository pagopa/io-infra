variable "cosmos_db_name" {
  type = string
}

variable "project" {
  type = string
}

variable "function_services_subscription_cidrs_max_thoughput" {
  type    = number
  default = 1000
}
