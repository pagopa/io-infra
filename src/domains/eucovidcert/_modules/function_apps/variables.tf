variable "project" {
  type        = string
  description = "IO prefix and short environment"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where resources will be created"
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet to use for Function Apps"
}

variable "storage_account_eucovidcert_primary_connection_string" {
  type        = string
  sensitive   = true
  description = "EuCovidCert StorageAccount connection string to save into app configs"
}
