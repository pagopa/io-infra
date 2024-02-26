variable "env_short" {
  type        = string
  description = "Environment name"
}

variable "tags" {
  type = map(any)
}

variable "vnet_resource_group_name" {
  type = string
}

variable "cidr_subnet_pendpoints" {
  type        = list(string)
  description = "Private Endpoints address space."
}
