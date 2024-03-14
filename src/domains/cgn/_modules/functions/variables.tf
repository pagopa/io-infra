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

variable "subnet_private_endpoints_id" {
  type        = string
  description = "Id of the subnet which holds private endpoints"
}

variable "cosmos_db" {
  type = object({
    endpoint    = string
    primary_key = string
  })

  sensitive   = true
  description = "Cosmos Account endpoint and primary key that Function Apps must use"
}

variable "cgn_storage_account_connection_string" {
  type        = string
  sensitive   = true
  description = "CGN Storage Account blob connection string"
}

variable "redis" {
  type = object({
    hostname           = string
    ssl_port           = string
    primary_access_key = string
  })

  sensitive   = true
  description = "Redis hostname, port and access key that Function Apps must use"
}
