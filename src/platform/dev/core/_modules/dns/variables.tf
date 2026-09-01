variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "dns" {
  description = "Global DNS configuration"

  type = object({
    resource_groups = map(string)
    vnets = map(object({
      id   = string
      name = string
    }))
  })
}
