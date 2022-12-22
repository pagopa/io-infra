data "azurerm_notification_hub" "common" {
  name                = format("%s-common", var.nh_name_prefix)
  namespace_name      = format("%s-common", var.nh_namespace_prefix)
  resource_group_name = var.nh_resource_group_name
}

data "azurerm_notification_hub" "common_partition" {
  count               = var.nh_partition_count
  name                = format("%s-common-partition-%d", var.nh_name_prefix, count.index + 1)
  namespace_name      = format("%s-common-partition-%d", var.nh_namespace_prefix, count.index + 1)
  resource_group_name = var.nh_resource_group_name
}