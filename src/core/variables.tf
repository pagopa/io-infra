# general

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

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

# DNS
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "external_domain" {
  type        = string
  default     = "pagopa.it"
  description = "Domain for delegation"
}

variable "dns_zone_io" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "dns_zone_io_selfcare" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

# azure devops
variable "azdo_sp_tls_cert_enabled" {
  type        = string
  description = "Enable Azure DevOps connection for TLS cert management"
  default     = false
}

variable "enable_azdoa" {
  type        = bool
  description = "Enable Azure DevOps agent."
}

variable "cidr_subnet_azdoa" {
  type        = list(string)
  description = "Azure DevOps agent network address space."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}

## Monitor
variable "log_analytics_workspace_name" {
  type        = string
  description = "The common Log Analytics Workspace name"
  default     = ""
}

variable "application_insights_name" {
  type        = string
  description = "The common Application Insights name"
  default     = ""
}
##

## Network
variable "common_rg" {
  type        = string
  description = "Common Virtual network resource group name."
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "Common Virtual network resource name."
  default     = ""
}

variable "cidr_subnet_eventhub" {
  type        = list(string)
  description = "Eventhub network address space."
}

variable "cidr_subnet_fnelt" {
  type        = list(string)
  description = "function-elt network address space."
}

variable "cidr_subnet_fnpblevtdispatcher" {
  type        = list(string)
  description = "function-publiceventdispatcher network address space."
}

variable "cidr_subnet_appgateway" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "Api Management address space."
}

variable "cidr_subnet_vpn" {
  type        = list(string)
  description = "VPN network address space."
}

variable "cidr_subnet_dnsforwarder" {
  type        = list(string)
  description = "DNS Forwarder network address space."
}

variable "cidr_subnet_selfcare_be" {
  type        = list(string)
  description = "Selfcare IO frontend storage address space."
}

variable "cidr_subnet_appbackendl1" {
  type        = list(string)
  description = "App backend l1 address space."
}

variable "cidr_subnet_appbackendl2" {
  type        = list(string)
  description = "App backend l1 address space."
}

variable "cidr_subnet_appbackendli" {
  type        = list(string)
  description = "App backend li address space."
}

## VPN ##
variable "vpn_sku" {
  type        = string
  default     = "VpnGw1"
  description = "VPN Gateway SKU"
}

variable "vpn_pip_sku" {
  type        = string
  default     = "Basic"
  description = "VPN GW PIP SKU"
}

## Application Gateway
variable "app_gateway_api_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_api_app_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_api_mtls_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_api_io_italia_it_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_app_backend_io_italia_it_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_developerportal_backend_io_italia_it_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_api_io_selfcare_pagopa_it_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "app_gateway_max_capacity" {
  type    = number
  default = 2
}

variable "app_gateway_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
}
##

## Apim
variable "apim_publisher_name" {
  type = string
}

variable "apim_sku" {
  type = string
}
##

## Redis cache
variable "redis_apim_capacity" {
  type    = number
  default = 1
}

variable "redis_apim_sku_name" {
  type    = string
  default = "Standard"
}

variable "redis_apim_family" {
  type    = string
  default = "C"
}

variable "cidr_subnet_redis_apim" {
  type        = list(string)
  description = "Redis network address space."
  default     = []
}
##

## Event hub
variable "ehns_sku_name" {
  type        = string
  description = "Defines which tier to use."
  default     = "Basic"
}

variable "ehns_capacity" {
  type        = number
  description = "Specifies the Capacity / Throughput Units for a Standard SKU namespace."
  default     = null
}

variable "ehns_maximum_throughput_units" {
  type        = number
  description = "Specifies the maximum number of throughput units when Auto Inflate is Enabled"
  default     = null
}

variable "ehns_auto_inflate_enabled" {
  type        = bool
  description = "Is Auto Inflate enabled for the EventHub Namespace?"
  default     = false
}

variable "ehns_zone_redundant" {
  type        = bool
  description = "Specifies if the EventHub Namespace should be Zone Redundant (created across Availability Zones)."
  default     = false
}

variable "eventhubs" {
  description = "A list of event hubs to add to namespace."
  type = list(object({
    name              = string
    partitions        = number
    message_retention = number
    consumers         = list(string)
    keys = list(object({
      name   = string
      listen = bool
      send   = bool
      manage = bool
    }))
  }))
  default = []
}

variable "ehns_ip_rules" {
  description = "eventhub network rules"
  type = list(object({
    ip_mask = string
    action  = string
  }))
  default = []
}

variable "ehns_alerts_enabled" {
  type        = bool
  default     = true
  description = "Event hub alerts enabled?"
}

variable "ehns_metric_alerts" {
  default = {}

  description = <<EOD
Map of name = criteria objects
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    metric_name = string
    description = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = list(object(
      {
        name     = string
        operator = string
        values   = list(string)
      }
    ))
  }))
}

# eucovidcert
variable "eucovidcert_alerts_enabled" {
  description = "Enable eucovidcert alerts"
  type        = bool
  default     = true
}

# app backend
variable "app_backend_plan_sku_tier" {
  description = "App backend app plan sku tier"
  type        = string
  default     = "PremiumV3"
}

variable "app_backend_plan_sku_size" {
  description = "App backend app plan sku size"
  type        = string
  default     = "P1v3"
}

variable "app_backend_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "app_backend_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 20
}

variable "app_backend_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 5
}

# selfcare
variable "selfcare_external_hostname" {
  description = "Selfcare external hostname"
  type        = string
  default     = "selfcare.pagopa.it"
}

variable "selfcare_plan_sku_tier" {
  description = "Selfcare app plan sku tier"
  type        = string
  default     = "PremiumV3"
}

variable "selfcare_plan_sku_size" {
  description = "Selfcare app plan sku size"
  type        = string
  default     = "P1v3"
}

variable "selfcare_plan_sku_capacity" {
  description = "Selfcare app plan capacity"
  type        = number
  default     = 1
}


# legal backup storage
variable "legalbackup_account_replication_type" {
  type        = string
  description = "Legal backup replication type"
  default     = "GRS"
}

variable "legalbackup_enable_versioning" {
  type        = bool
  description = "Enable legal backup versioning"
  default     = false
}

variable "legalbackup_advanced_threat_protection" {
  type        = bool
  description = "Enable legal backup threat advanced protection"
  default     = false
}

