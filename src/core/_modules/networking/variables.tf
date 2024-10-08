variable "project" {
  type        = string
  description = "IO prefix, short environment and short location"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "location_short" {
  type        = string
  description = "Azure region short name"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VNet"
}

variable "vnet_cidr_block" {
  type        = string
  description = "CIDR block allocated in the common vnet"
}

variable "pep_snet_cidr" {
  type        = list(string)
  description = "CIDR block allocated in the private endpoints subnet"
}

variable "ng_ips_number" {
  type        = number
  description = "Number of public IPs assigned to the nat gateway"
  default     = 1
}

variable "ng_number" {
  type        = number
  description = "Number of nat gateways to deploy"
  default     = 1
}


variable "ng_ippres_number" {
  type        = number
  description = "Number of Public IP Prefix assigned to the nat gateway"
  default     = 3
}
