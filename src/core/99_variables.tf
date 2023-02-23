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

## Monitor
variable "law_sku" {
  type        = string
  description = "Sku of the Log Analytics Workspace"
  default     = "PerGB2018"
}

variable "law_retention_in_days" {
  type        = number
  description = "The workspace data retention in days"
  default     = 90
}

variable "law_daily_quota_gb" {
  type        = number
  description = "The workspace daily quota for ingestion in GB."
  default     = -1
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

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}


##

#
# Network
#
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

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "cidr_common_vnet" {
  type        = list(string)
  description = "Common Virtual network cidr."
}

variable "cidr_weu_beta_vnet" {
  type        = list(string)
  description = "Beta Virtual network cidr."
}

variable "cidr_weu_prod01_vnet" {
  type        = list(string)
  description = "Prod01 Virtual network cidr."
}

variable "cidr_weu_prod02_vnet" {
  type        = list(string)
  description = "Prod02 Virtual network cidr."
}

## Subnet CIRDS
variable "cidr_subnet_redis_common" {
  type        = list(string)
  description = "Redis common network address space."
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

variable "cidr_subnet_fnpblevtdispatcherv4" {
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

variable "cidr_subnet_devportalservicedata_db_server" {
  type        = list(string)
  description = "Space address for DevPortal Service Data PostgresSQL"
}

variable "cidr_subnet_appbackendl1" {
  type        = list(string)
  description = "App backend l1 address space."
}

variable "cidr_subnet_appbackendl2" {
  type        = list(string)
  description = "App backend l2 address space."
}

variable "cidr_subnet_app" {
  type        = list(string)
  description = "Function app address space."
}

variable "cidr_subnet_services" {
  type        = list(string)
  description = "Function services address space."
}

variable "cidr_subnet_app_async" {
  type        = list(string)
  description = "Function app async address space."
}

variable "cidr_subnet_appmessages" {
  type        = list(string)
  description = "App messages address space."
}

variable "cidr_subnet_fnmessagescqrs" {
  type        = list(string)
  description = "Fn cqrs address space."
}

variable "cidr_subnet_fncdnassets" {
  type        = list(string)
  description = "Fn assets address space."
}

variable "cidr_subnet_appbackendli" {
  type        = list(string)
  description = "App backend li address space."
}

variable "cidr_subnet_cgn" {
  type        = list(string)
  description = "Function cgn address space."
}

variable "cidr_subnet_shared_1" {
  type        = list(string)
  description = "Function cgn address space."
}

variable "cidr_subnet_eucovidcert" {
  type        = list(string)
  description = "Function App EUCovidCert address space."
}

variable "cidr_subnet_fnadmin" {
  type        = list(string)
  description = "Function Admin address space."
}

variable "cidr_subnet_pendpoints" {
  type        = list(string)
  description = "Private Endpoints address space."
}

variable "cidr_subnet_fnlollipop" {
  type        = list(string)
  description = "Function Lollipop address space."
}

## REDIS COMMON ##
variable "redis_common" {
  type = object({
    capacity                      = number
    shard_count                   = number
    family                        = string
    sku_name                      = string
    public_network_access_enabled = bool
  })
  description = "Redis Common configuration"
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

variable "apim_autoscale" {
  type = object(
    {
      enabled                       = bool
      default_instances             = number
      minimum_instances             = number
      maximum_instances             = number
      scale_out_capacity_percentage = number
      scale_out_time_window         = string
      scale_out_value               = string
      scale_out_cooldown            = string
      scale_in_capacity_percentage  = number
      scale_in_time_window          = string
      scale_in_value                = string
      scale_in_cooldown             = string
    }
  )
  description = "Configure Apim autoscale on capacity metric"
}

variable "apim_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = true
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

# services
variable "service_alerts_enabled" {
  description = "Enable services alerts"
  type        = bool
  default     = true
}

variable "service_availability_alerts_threshold" {
  description = "Threshold availability services alert"
  type        = number
  default     = 99.0
}

# eucovidcert
variable "eucovidcert_alerts_enabled" {
  description = "Enable eucovidcert alerts"
  type        = bool
  default     = true
}

# app backend

variable "app_backend_names" {
  description = "App backend instance names"
  type        = list(string)
  default     = []
}

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
  default     = 30
}

variable "app_backend_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 10
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
variable "cgn_legalbackup_account_replication_type" {
  type        = string
  description = "Legal backup replication type"
  default     = "GRS"
}

variable "cgn_legalbackup_enable_versioning" {
  type        = bool
  description = "Enable legal backup versioning"
  default     = false
}

## Azure container registry
# variable "sku_container_registry" {
#   type    = string
#   default = "Basic"
# }

# variable "retention_policy_acr" {
#   type = object({
#     days    = number
#     enabled = bool
#   })
#   default = {
#     days    = 7
#     enabled = true
#   }
#   description = "Container registry retention policy."
# }

# Function App
variable "function_app_count" {
  type    = number
  default = 2
}

variable "function_app_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_app_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_app_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_app_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_app_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_app_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

################################
# Function Services
################################
variable "function_services_count" {
  type    = number
  default = 2
}

variable "function_services_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_services_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_services_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_services_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_services_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_services_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}



# Function App Async
variable "function_app_async_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_app_async_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_app_async_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_app_async_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_app_async_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_app_async_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Function Admin

variable "function_admin_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_admin_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_admin_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_admin_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_admin_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_admin_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# App Messages
variable "app_messages_count" {
  type    = number
  default = 2
}

variable "app_messages_function_always_on" {
  type    = bool
  default = false
}

variable "app_messages_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "app_messages_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "app_messages_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "app_messages_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "app_messages_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "app_messages_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Functions Messages CQRS

variable "function_messages_cqrs_always_on" {
  type    = bool
  default = false
}

variable "function_messages_cqrs_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_messages_cqrs_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_messages_cqrs_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_messages_cqrs_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_messages_cqrs_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_messages_cqrs_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

variable "function_assets_cdn_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_assets_cdn_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_assets_cdn_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_assets_cdn_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_assets_cdn_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_assets_cdn_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}
##

# PN Service Id
variable "pn_service_id" {
  type        = string
  description = "The Service ID of PN service"
  default     = "01G40DWQGKY5GRWSNM4303VNRP"
}

# io-sign service Id
variable "io_sign_service_id" {
  type        = string
  description = "The Service ID of io-sign service"
  default     = "01GQQZ9HF5GAPRVKJM1VDAVFHM"
}


# Function CGN
variable "plan_cgn_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "plan_cgn_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "plan_cgn_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "plan_cgn_sku_capacity" {
  description = "Cgn app plan capacity"
  type        = number
  default     = 1
}

variable "function_cgn_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_cgn_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_cgn_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Function EUCovidCert
variable "function_eucovidcert_count" {
  type    = number
  default = 2
}

variable "function_eucovidcert_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_eucovidcert_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_eucovidcert_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_eucovidcert_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_eucovidcert_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 30
}

variable "function_eucovidcert_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Shared functions
variable "plan_shared_1_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "plan_shared_1_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "plan_shared_1_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "plan_shared_1_sku_capacity" {
  description = "Shared functions app plan capacity"
  type        = number
  default     = 1
}

variable "function_public_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_public_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_public_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Third Party Mock

variable "third_party_mock_service_id" {
  type        = string
  description = "The Service ID of the Third Party Mock service"
  default     = "01GQQDPM127KFGG6T3660D5TXD"
}
