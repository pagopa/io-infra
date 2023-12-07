# general

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
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

variable "enable_azdoa" {
  type        = bool
  description = "Specifies Azure Devops Agent enabling"
  default     = true
}

variable "elastic_node_pool" {
  type = object({
    enabled               = bool,
    name                  = string,
    vm_size               = string,
    os_disk_type          = string,
    os_disk_size_gb       = string,
    node_count_min        = number,
    node_count_max        = number,
    node_labels           = map(any),
    node_taints           = list(string),
    node_tags             = map(any),
    elastic_pool_max_pods = number,
  })
  description = "AKS node pool user configuration"
}

variable "elastic_hot_storage" {
  type = object({
    storage_type           = string,
    allow_volume_expansion = bool,
    initialStorageSize     = string
  })
}

variable "ingress_elk_load_balancer_ip" {
  type = string
}

variable "ingress_min_replica_count" {
  type = string
}

variable "ingress_max_replica_count" {
  type = string
}

variable "nginx_helm" {
  type = object({
    version = string,
    controller = object({
      image = object({
        registry     = string,
        image        = string,
        tag          = string,
        digest       = string,
        digestchroot = string,
      }),
      config = object({
        proxy-body-size : string
      })
    })
  })
  description = "nginx ingress helm chart configuration"
}

variable "nodeset_config" {
  type = map(object({
    count            = string
    roles            = list(string)
    storage          = string
    storageClassName = string
  }))
  default = {
    default = {
      count            = 1
      roles            = ["master", "data", "data_content", "data_hot", "data_warm", "data_cold", "data_frozen", "ingest", "ml", "remote_cluster_client", "transform"]
      storage          = "5Gi"
      storageClassName = "standard"
    }
  }
}

variable "elk_snapshot_sa" {
  type = object({
    blob_delete_retention_days = number
    backup_enabled             = bool
    blob_versioning_enabled    = bool
    advanced_threat_protection = bool
  })
  default = {
    blob_delete_retention_days = 0
    backup_enabled             = false
    blob_versioning_enabled    = true
    advanced_threat_protection = true
  }
}
