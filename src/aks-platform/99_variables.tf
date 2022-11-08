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

variable "aks_kubernetes_version" {
  type        = string
  description = "Kubernetes version specified when creating the AKS managed cluster."
  default     = "1.23.5"
}

variable "aks_sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA)."
}

variable "aks_system_node_pool" {
  type = object({
    name                         = string,
    vm_size                      = string,
    os_disk_type                 = string,
    os_disk_size_gb              = string,
    node_count_min               = number,
    node_count_max               = number,
    only_critical_addons_enabled = bool,
    node_labels                  = map(any),
    node_tags                    = map(any)
  })
  description = "AKS node pool system configuration"
}

variable "aks_user_node_pool" {
  type = object({
    enabled         = bool,
    name            = string,
    vm_size         = string,
    os_disk_type    = string,
    os_disk_size_gb = string,
    node_count_min  = number,
    node_count_max  = number,
    node_labels     = map(any),
    node_taints     = list(string),
    node_tags       = map(any)
  })
  description = "AKS node pool user configuration"
}

variable "aks_cidr_subnet" {
  type        = list(string)
  description = "Aks network address space."
}

variable "aks_num_outbound_ips" {
  type        = number
  default     = 1
  description = "How many outbound ips allocate for AKS cluster"
}

variable "ingress_load_balancer_ip" {
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
    }),
  })
  description = "nginx ingress helm chart configuration"
}

variable "keda_helm" {
  type = object({
    chart_version = string,
    keda = object({
      image_name = string,
      image_tag  = string,
    }),
    metrics_api_server = object({
      image_name = string,
      image_tag  = string,
    }),
  })
  description = "keda helm chart configuration"
}

variable "reloader_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "reloader helm chart configuration"
}

variable "prometheus_helm" {
  type = object({
    chart_version = string,
    alertmanager = object({
      image_name = string,
      image_tag  = string,
    }),
    configmap_reload_prometheus = object({
      image_name = string,
      image_tag  = string,
    }),
    configmap_reload_alertmanager = object({
      image_name = string,
      image_tag  = string,
    }),
    configmap_reload_prometheus = object({
      image_name = string,
      image_tag  = string,
    }),
    node_exporter = object({
      image_name = string,
      image_tag  = string,
    }),
    server = object({
      image_name = string,
      image_tag  = string,
    }),
    pushgateway = object({
      image_name = string,
      image_tag  = string,
    }),
  })
  description = "prometheus helm chart configuration"
}

variable "tls_cert_check_helm" {
  type = object({
    chart_version = string,
    image_name    = string,
    image_tag     = string
  })
  description = "tls cert helm chart configuration"
}

# variable "grafana_helm_version" {
#   type = string
# }
