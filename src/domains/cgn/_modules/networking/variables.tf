variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "cidr_subnet_redis" {
  type        = list(string)
  description = "CIDR block for Redis subnet"
}

variable "cidr_subnet_cgn" {
  type        = list(string)
  description = "CIDR block for CGN subnet"
}
