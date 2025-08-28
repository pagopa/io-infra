variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name for VNet"
}

variable "vnets" {
  type = map(object({
    id   = string
    name = string
  }))
  description = "Map of virtual networks where to attach private dns zones"
}
