variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "apim" {
  type = object({
    name                = string
    resource_group_name = string
  })
  description = "API Management"
}