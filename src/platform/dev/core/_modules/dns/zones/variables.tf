variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_groups" {
  type        = map(string)
  description = "Resource group names"
}

variable "vnets" {
  type = map(object({
    id   = string
    name = string
  }))
  description = "Map of virtual networks where to attach private dns zones"
}
