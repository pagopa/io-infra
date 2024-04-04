variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "cidr_subnet_continua" {
  type        = list(string)
  description = "CIDR block for Continua subnet"
}
