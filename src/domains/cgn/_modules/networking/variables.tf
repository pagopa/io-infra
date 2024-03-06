variable "project" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "cidr_subnet_redis" {
  type = list(string)
}

variable "cidr_subnet_cgn" {
  type = list(string)
}
