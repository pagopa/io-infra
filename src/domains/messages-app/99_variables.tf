# general

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) < 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) == 1
    )
    error_message = "Length must be 1 chars."
  }
}

variable "domain" {
  type = string
  validation {
    condition = (
      length(var.domain) <= 12
    )
    error_message = "Max length is 12 chars."
  }
}

variable "location" {
  type        = string
  description = "One of westeurope, northeurope"
}

variable "location_short" {
  type = string
  validation {
    condition = (
      length(var.location_short) == 3
    )
    error_message = "Length must be 3 chars."
  }
  description = "One of wue, neu"
}

variable "location_string" {
  type        = string
  description = "One of West Europe, North Europe"
}

variable "instance" {
  type        = string
  description = "One of beta, prod01, prod02"
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

### External resources

variable "monitor_resource_group_name" {
  type        = string
  description = "Monitor resource group name"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Specifies the name of the Log Analytics Workspace."
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "The name of the resource group in which the Log Analytics workspace is located in."
}

variable "application_insights_name" {
  type        = string
  description = "Specifies the name of the Application Insights."
}

### Aks

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "reloader_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "reloader helm chart configuration"
}

variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
}

variable "tls_cert_check_enabled" {
  type        = bool
  description = "Enable tls cert check"
}

## Event hub

variable "ehns_enabled" {
  type        = bool
  description = "Enable event hub namespace"
  default     = false
}

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

variable "ehns_virtual_network_rules" {
  description = "eventhub virtual network rules"
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


variable "nh_resource_group_name" {
  type        = string
  description = "Notification Hub resource group name"
}

variable "nh_name_prefix" {
  type        = string
  description = "Notification Hub name prefix"
}
variable "nh_namespace_prefix" {
  type        = string
  description = "Notification Hub namespace prefix"
}

variable "nh_partition_count" {
  type        = number
  description = "Notification Hub partition count"
  default     = 4
}

variable "enable_azdoa" {
  type        = bool
  description = "Specifies Azure Devops Agent enabling"
  default     = true
}

###############################
# Push Notification
###############################

variable "cidr_subnet_push_notif" {
  type        = list(string)
  description = "Function push-notif address space."
}

variable "push_notif_enabled" {
  type        = bool
  default     = false
  description = "Push Notif function enabled?"
}

variable "push_notif_count" {
  type    = number
  default = 2
}

variable "push_notif_function_always_on" {
  type    = bool
  default = false
}

variable "push_notif_function_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "push_notif_function_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "push_notif_function_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "push_notif_function_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "push_notif_function_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "push_notif_function_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

###############################
# Messages functions
###############################
variable "app_messages_count" {
  type    = number
  default = 0
}

variable "cidr_subnet_appmessages" {
  type        = list(string)
  description = "App messages address space."
  default     = []
}

variable "pn_service_id" {
  type        = string
  description = "The Service ID of PN service"
  default     = "01G40DWQGKY5GRWSNM4303VNRP"
}

variable "io_sign_service_id" {
  type        = string
  description = "The Service ID of io-sign service"
  default     = "01GQQZ9HF5GAPRVKJM1VDAVFHM"
}

variable "io_receipt_service_test_id" {
  type        = string
  description = "The Service ID of io-receipt service"
  default     = "01H4ZJ62C1CPGJ0PX8Q1BP7FAB"
}

variable "io_receipt_service_id" {
  type        = string
  description = "The Service ID of io-receipt service"
  default     = "01HD63674XJ1R6XCNHH24PCRR2"
}

variable "third_party_mock_service_id" {
  type        = string
  description = "The Service ID of the Third Party Mock service"
  default     = "01GQQDPM127KFGG6T3660D5TXD"
}

variable "pn_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of PN service"
  default     = "01HMVMHCZZ8D0VTFWMRHBM5D6F"
}

variable "io_sign_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of io-sign service"
  default     = "01HMVMDTHXCESMZ72NA701EKGQ"
}

variable "io_receipt_remote_config_test_id" {
  type        = string
  description = "The Remote Content Config ID of io-receipt service"
  default     = "01HMVMCDD3JFYTPKT4ZN4WQ73B"
}

variable "io_receipt_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of io-receipt service"
  default     = "01HMVM9W74RWH93NT1EYNKKNNR"
}

variable "third_party_mock_remote_config_id" {
  type        = string
  description = "The Remote Content Config ID of the Third Party Mock service"
  default     = "01HMVM4N4XFJ8VBR1FXYFZ9QFB"
}

###############################
# Messages cqrs functions
###############################
variable "cidr_subnet_fnmessagescqrs" {
  type        = list(string)
  description = "Fn cqrs address space."
}

###############################
# Service messages functions
###############################
variable "cidr_subnet_fnservicemessages" {
  type        = list(string)
  description = "Functions service messages address space."
}

variable "function_service_messages_enabled" {
  type        = bool
  default     = false
  description = "Functions service messages enabled?"
}




