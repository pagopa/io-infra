# GermanyWestCentral

resource "azurerm_private_endpoint" "bonus_backup_gwc_01_blob_pep" {
  name                = "${azurerm_storage_account.bonus_backup_gwc_01.name}-blob-endpoint"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${azurerm_storage_account.bonus_backup_gwc_01.name}-blob-endpoint"
    private_connection_resource_id = azurerm_storage_account.bonus_backup_gwc_01.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.blob_storage_account.id]
  }

  tags = local.tags
}

resource "azurerm_private_endpoint" "bonus_backup_gwc_01_table_pep" {
  name                = "${azurerm_storage_account.bonus_backup_gwc_01.name}-table-endpoint"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${azurerm_storage_account.bonus_backup_gwc_01.name}-table-endpoint"
    private_connection_resource_id = azurerm_storage_account.bonus_backup_gwc_01.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.table_storage_account.id]
  }

  tags = local.tags
}

# ItalyNorth

resource "azurerm_private_endpoint" "bonus_backup_itn_01_blob_pep" {
  name                = "${azurerm_storage_account.bonus_backup_itn_01.name}-blob-endpoint"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${azurerm_storage_account.bonus_backup_itn_01.name}-blob-endpoint"
    private_connection_resource_id = azurerm_storage_account.bonus_backup_itn_01.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.blob_storage_account.id]
  }

  tags = local.tags
}

resource "azurerm_private_endpoint" "bonus_backup_itn_01_table_pep" {
  name                = "${azurerm_storage_account.bonus_backup_itn_01.name}-table-endpoint"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg_itn_01.name
  subnet_id           = data.azurerm_subnet.pep.id

  private_service_connection {
    name                           = "${azurerm_storage_account.bonus_backup_itn_01.name}-table-endpoint"
    private_connection_resource_id = azurerm_storage_account.bonus_backup_itn_01.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.table_storage_account.id]
  }

  tags = local.tags
}
