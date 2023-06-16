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

variable "lollipop_enabled" {
  type        = bool
  default     = false
  description = "Lollipop function enabled?"
}

variable "fastlogin_enabled" {
  type        = bool
  default     = false
  description = "Fast login LC creation flag"
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

variable "enable_azdoa" {
  type        = bool
  description = "Specifies Azure Devops Agent enabling"
  default     = true
}


# Function LolliPOP

variable "cidr_subnet_fnlollipop" {
  type        = list(string)
  description = "Function Lollipop address space."
}

variable "function_lollipop_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_lollipop_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_lollipop_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_lollipop_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_lollipop_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_lollipop_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}

# Function Fast Login

variable "cidr_subnet_fnfastlogin" {
  type        = list(string)
  description = "Function Lollipop address space."
}

variable "function_fastlogin_kind" {
  type        = string
  description = "App service plan kind"
  default     = null
}

variable "function_fastlogin_sku_tier" {
  type        = string
  description = "App service plan sku tier"
  default     = null
}

variable "function_fastlogin_sku_size" {
  type        = string
  description = "App service plan sku size"
  default     = null
}

variable "function_fastlogin_autoscale_minimum" {
  type        = number
  description = "The minimum number of instances for this resource."
  default     = 1
}

variable "function_fastlogin_autoscale_maximum" {
  type        = number
  description = "The maximum number of instances for this resource."
  default     = 3
}

variable "function_fastlogin_autoscale_default" {
  type        = number
  description = "The number of instances that are available for scaling if metrics are not available for evaluation."
  default     = 1
}