data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name = "privatelink.blob.core.windows.net"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name = "privatelink.queue.core.windows.net"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name = "privatelink.table.core.windows.net"
  resource_group_name = "${local.project}-rg-common"
}
