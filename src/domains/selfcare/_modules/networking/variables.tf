variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "cidr_subnet_selfcare_be" {
  type        = string
  description = "CIDR for Selfcare BE subnet"
}

