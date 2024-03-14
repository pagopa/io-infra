variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "env_short" {
  type        = string
  description = "Short environment name"
}

variable "function_cgn_merchant_hostname" {
  type        = string
  description = "CGN Function App hostname to set in API groups"
}
