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

variable "application_insights_name" {
  type        = string
  description = "Specifies the name of the Application Insights."
}

####################
# Session manager ##
####################
variable "cidr_subnet_session_manager" {
  type        = list(string)
  description = "Session manager app service address space."
}

variable "cidr_subnet_session_manager_bis" {
  type        = list(string)
  description = "Session manager second instance app service address space."
}

variable "session_manager_plan_sku_name" {
  description = "App service plan sku name"
  type        = string
  default     = "P1v3"
}

####################

# DNS
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

###########################
