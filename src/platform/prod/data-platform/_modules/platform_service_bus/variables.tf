variable "prefix" {
  type    = string
  default = "io"
  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_internal" {
  type        = string
  description = "Name of internal resource group"
}

variable "resource_group_event" {
  type        = string
  description = "Name of event resource group"
}

variable "pep_snet_id" {
  type        = string
  description = "ID of Private endpoints dedicated subnet"
}
