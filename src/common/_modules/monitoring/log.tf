resource "azurerm_log_analytics_workspace" "log" {
  name                = try(local.nonstandard[var.location_short].log, "${var.project}-log-01")
  location            = var.location
  resource_group_name = var.resource_group_common
  sku                 = "PerGB2018"
  retention_in_days   = "90"
  daily_quota_gb      = "-1"

  lifecycle {
    ignore_changes = [
      # Ignore changes to sku because the azurerm module doesn't support LACluster.
      # This is a workaround for https://github.com/hashicorp/terraform-provider-azurerm/issues/28743
      sku,
    ]
  }

  tags = var.tags
}
