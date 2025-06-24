output "subscription_id" {
  description = <<EOF
  WHAT: The subscription ID of the current Azure subscription.
  EOF
  value = data.azurerm_client_config.current.subscription_id
}

output "tenant_id" {
  description = <<EOF
  WHAT: The tenant ID of the current Azure subscription.
  EOF
  value = data.azurerm_client_config.current.tenant_id
}

output "resource_groups" {
  description = <<EOF
  WHAT: All resource groups into itn and weu regions
  EOF
  value = {
    weu = {
      common   = "${local.project_weu_legacy}-rg-common"
      internal = "${local.project_weu_legacy}-rg-internal"
      external = "${local.project_weu_legacy}-rg-external"
      event    = "${local.project_weu_legacy}-evt-rg"
      sec      = "${local.project_weu_legacy}-sec-rg"
      linux    = "${local.project_weu_legacy}-rg-linux"
      opex     = "dashboards"
    },
    itn = {
      common   = "${local.project_itn}-common-rg-01"
      internal = "${local.project_itn}-common-rg-01"
      external = "${local.project_itn}-common-rg-01"
      event    = "${local.project_itn}-common-rg-01"
      sec      = "${local.project_itn}-sec-rg-01"
      linux    = "${local.project_itn}-common-rg-01"
      opex     = "${local.project_itn}-common-dashboards-rg-01"
    }
  }
}

output "apim" {
  description = <<EOF
  WHAT: APIMs into itn and weu regions
  EOF
  value = {
    itn = {
      id                      = local.common.apim.itn.id
    }
    weu = {
      id                      = null
    }
  }
}

output "service_bus_namespace" {
  description = <<EOF
  WHAT: The centralized Service Bus Namespace into itn and weu regions
  EOF
  value = {
    itn = {
      id                      = local.common.platform_service_bus_namespace.id
      name                    = local.common.platform_service_bus_namespace.name
      resource_group_name     = local.common.platform_service_bus_namespace.resource_group_name
    }
    weu = {
      id                      = null
      name                    = null
      resource_group_name     = null
    }
  }
}

output "log_analytics_workspace" {
  description = <<EOF
  WHAT: The Log Analytics Workspace into itn and weu regions
  EOF
  value = {
    itn = {
      id                      = local.common.log_analytics_workspace.id
      name                    = local.common.log_analytics_workspace.name
      resource_group_name     = local.common.log_analytics_workspace.resource_group_name
    }
    weu = {
      id                      = local.common.log_analytics_workspace.id
      name                    = local.common.log_analytics_workspace.name
      resource_group_name     = local.common.log_analytics_workspace.resource_group_name
    }
  }
}

output "key_vault" {
  description = <<EOF
  WHAT: The Key Vaults into itn and weu regions
  FORMAT: https://github.com/pagopa/io-infra/blob/main/src/core/_modules/key_vaults/outputs.tf
  EOF
  value = {
    itn = local.common.key_vault.itn
    weu = local.common.key_vault.weu
  }
}
