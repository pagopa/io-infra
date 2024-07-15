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

variable "location_in" {
  type    = string
  default = "italynorth"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of weu, neu"
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

variable "dns_zone_firmaconio_selfcare" {
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

variable "azdoa_image_name" {
  type        = string
  description = "Azure DevOps Agent image name"
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

variable "cidr_common_in_vnet" {
  type        = list(string)
  description = "Common Italy North Virtual network cidr."
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

variable "cidr_subnet_appgateway" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "Old Api Management address space."
}

variable "cidr_subnet_apim_v2" {
  type        = list(string)
  description = "Api Management V2 address space."
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

variable "cidr_subnet_appbackendli" {
  type        = list(string)
  description = "App backend li address space."
}

variable "cidr_subnet_shared_1" {
  type = list(string)
}

variable "cidr_subnet_pendpoints" {
  type        = list(string)
  description = "Private Endpoints address space."
}

variable "cidr_subnet_fnlollipop" {
  type        = list(string)
  description = "Function Lollipop address space."
}

variable "cidr_subnet_fnfastlogin" {
  type        = list(string)
  description = "Function Fast Login address space."
}

## REDIS COMMON ##
variable "redis_common" {
  type = object({
    capacity                      = number
    shard_count                   = number
    family                        = string
    sku_name                      = string
    public_network_access_enabled = bool
    rdb_backup_enabled            = bool
    rdb_backup_frequency          = number
    rdb_backup_max_snapshot_count = number
    redis_version                 = string
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

variable "app_gateway_api_web_certificate_name" {
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

variable "app_gateway_oauth_io_pagopa_it_certificate_name" {
  type        = string
  description = "Application gateway oauth certificate name on Key Vault"
}

variable "app_gateway_firmaconio_selfcare_pagopa_it_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

variable "app_gateway_continua_io_pagopa_it_certificate_name" {
  type        = string
  description = "Application gateway continua certificate name on Key Vault"
}

variable "app_gateway_selfcare_io_pagopa_it_certificate_name" {
  type        = string
  description = "Application gateway selfcare-io certificate name on Key Vault"
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

variable "app_gateway_deny_paths" {
  type        = list(string)
  description = "Regex patterns to deny requests"
}
##

## Apim
variable "apim_publisher_name" {
  type = string
}

variable "apim_v2_sku" {
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
  default     = 2
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


##

# PN Service Id
variable "pn_service_id" {
  type        = string
  description = "The Service ID of PN service"
  default     = "01G40DWQGKY5GRWSNM4303VNRP"
}

variable "pn_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of PN service"
  default     = "01HMVMHCZZ8D0VTFWMRHBM5D6F"
}

# PN Test Endpoint
variable "pn_test_endpoint" {
  type        = string
  description = "The endpoint of PN (test env)"
}

# io-sign service Id
variable "io_sign_service_id" {
  type        = string
  description = "The Service ID of io-sign service"
  default     = "01GQQZ9HF5GAPRVKJM1VDAVFHM"
}

variable "io_sign_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of io-sign service"
  default     = "01HMVMDTHXCESMZ72NA701EKGQ"
}

variable "io_wallet_trial_id" {
  type        = string
  description = "The trial ID of io-wallet trial"
  default     = "01J2GN4TA8FB6DPTAX3T3YD6M1"
}

# io-receipt service
variable "io_receipt_service_id" {
  type        = string
  description = "The Service ID of io-receipt service"
}

variable "io_receipt_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of io-receipt service"
  default     = "01HMVM9W74RWH93NT1EYNKKNNR"
}

variable "io_receipt_service_url" {
  type        = string
  description = "The endpoint of Receipt Service (prod env)"
}

variable "io_receipt_service_test_id" {
  type        = string
  description = "The Service ID of io-receipt service"
}

variable "io_receipt_remote_config_test_id" {
  type        = string
  description = "The Remote Content Config ID of io-receipt service"
  default     = "01HMVMCDD3JFYTPKT4ZN4WQ73B"
}

variable "io_receipt_service_test_url" {
  type        = string
  description = "The endpoint of Receipt Service (test env)"
}

# Third Party Mock

variable "third_party_mock_service_id" {
  type        = string
  description = "The Service ID of the Third Party Mock service"
  default     = "01GQQDPM127KFGG6T3660D5TXD"
}

variable "third_party_mock_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of the Third Party Mock service"
  default     = "01HMVM4N4XFJ8VBR1FXYFZ9QFB"
}

# Citizen auth

variable "citizen_auth_domain" {
  type    = string
  default = "citizen-auth"
}

variable "citizen_auth_product" {
  type        = string
  description = "Use product name from citizen_auth domain locals"
  default     = "io-p"
}

variable "citizen_auth_revoke_queue_name" {
  type        = string
  description = "Use queue storage name from citizen_auth domain storage"
  default     = "pubkeys-revoke-v2"
}

variable "citizen_auth_assertion_storage_name" {
  type        = string
  description = "Use storage name from citizen_auth domain"
  default     = "lollipop-assertions-st"
}

# Functions
variable "function_services_count" {
  type    = number
  default = 2
}

variable "function_app_count" {
  type    = number
  default = 2
}
