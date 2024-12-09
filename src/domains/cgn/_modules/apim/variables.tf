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

variable "apim" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "API Management"
}
