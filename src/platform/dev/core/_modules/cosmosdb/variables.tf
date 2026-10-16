variable "resource_group_name" {
  type        = string
  description = "Resource group containing the Cosmos DB account."
}

variable "private_dns_zone_resource_group_name" {
  type        = string
  description = "Resource group containing the private DNS zone required by the DX module."
}

variable "tags" {
  type        = map(string)
  description = "Tags assigned to the Cosmos DB account."
}


variable "prefix" {
  type    = string
  default = "io"
  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 5 chars."
  }
}

variable "location" {
  type        = string
  description = "Azure region"
}