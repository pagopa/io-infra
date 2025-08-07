variable "common_resource_group_name_itn" {
  type        = string
  description = "name of the common itn resource group"
}

variable "vnet_common_name_itn" {
  type        = string
  description = "name of the common itn vnet"
}

variable "cidr_subnet_services" {
  type        = list(string)
  description = "Function services address space."
}

variable "project_itn" {
  type = string
}