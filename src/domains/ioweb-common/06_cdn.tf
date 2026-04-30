# TEMPORARY: module.landing_cdn has been removed from IaC management without
# destroying the underlying Azure resource (see `removed` block below).
#
# Root cause: incompatibility with the hashicorp/azurerm provider v4.
# Azure CDN Standard from Microsoft (classic) was deprecated on October 1, 2025.
# Starting from that date, the provider enforces the following constraint at
# plan/apply time:
#
#   Error: creation of new CDN resources is no longer permitted following its
#   deprecation on October 1, 2025. However, modifications to existing CDN
#   resources remain supported until the API reaches full retirement on
#   September 30, 2027.
#
# Background:
#   - August 15, 2025: Azure CDN classic stopped supporting new profile/domain
#     creation and managed certificate provisioning.
#   - October 1, 2025: azurerm v4 blocks any Terraform operation that would
#     create new classic CDN resources (including plan-time diffs that would
#     trigger a replace).
#   - September 30, 2027: full API retirement — no reads, writes, or management
#     of classic CDN resources will be possible.
#
# Resources removed from Terraform state (but NOT destroyed on Azure):
#   - module.landing_cdn.azurerm_cdn_profile.this
#   - module.landing_cdn.azurerm_cdn_endpoint.this
#   - module.landing_cdn.azurerm_dns_a_record.apex_hostname[0]
#   - module.landing_cdn.azurerm_dns_cname_record.apex_cdnverify[0]
#   - module.landing_cdn.azurerm_monitor_diagnostic_setting.diagnostic_settings_cdn_profile
#   - module.landing_cdn.null_resource.apex_custom_hostname[0]
#   - module.landing_cdn.module.cdn_storage_account.azurerm_storage_account.this
#   - module.landing_cdn.module.cdn_storage_account.azurerm_monitor_metric_alert.storage_account_low_availability[0]
#
# Next steps:
#   The resource will be migrated to Azure Front Door Standard/Premium in a
#   dedicated PR. Microsoft provides a zero-downtime migration tool:
#   https://learn.microsoft.com/en-us/azure/cdn/tier-migration

module "landing_cdn" {
  source              = "pagopa-dx/azure-cdn/azurerm"
  version             = "~> 0.0"
  resource_group_name = azurerm_resource_group.io_web_profile_itn_fe_rg.name

  origins = {
    custom-origin = {

      host_name = "d2m1nc4792c1zk.cloudfront.net"
      priority  = 1

    }
  }

  custom_domains = [
    {
      host_name = "ioapp.it"
      # TODO: enable dns block / import txt validation records 
      /*
      dns = {
        zone_name                = data.azurerm_dns_zone.ioapp_it.name
        zone_resource_group_name = data.azurerm_resource_group.core_ext.name
      }
      */
    }
  ]

  diagnostic_settings = {
    enabled                    = true
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.log_analytics.id
  }

  environment = {
    prefix          = "io"
    env_short       = "p"
    location        = local.itn_location
    app_name        = "ioweb"
    instance_number = "01"
  }
  tags = var.tags
}
