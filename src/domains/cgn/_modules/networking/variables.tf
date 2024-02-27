variable "env_short" {
  type        = string
  description = "Environment name"
}

variable "tags" {
  type = map(any)
}

variable "cidr_subnet_pendpoints" {
  type        = list(string)
  description = "Private Endpoints address space."
}

variable "cidr_subnet_redis" {
  type = list(string)
}
