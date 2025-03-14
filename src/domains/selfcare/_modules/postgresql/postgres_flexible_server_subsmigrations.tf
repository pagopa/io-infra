module "subscriptionmigrations_db_flex_server" {
  source = "github.com/pagopa/terraform-azurerm-v3//postgres_flexible_server?ref=v7.69.1"

  name                = "${var.project}-weu-subsmigrations-psql-01"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login    = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_username.value
  administrator_password = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_password.value

  sku_name                     = "GP_Standard_D2ds_v5"
  db_version                   = 11
  geo_redundant_backup_enabled = true
  zone                         = 3

  private_endpoint_enabled = false

  high_availability_enabled = false

  pgbouncer_enabled = true

  storage_mb = 32768 # 32GB

  alerts_enabled = true

  diagnostic_settings_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "pep" {
  name                = "${var.project}-weu-subsmigrations-psql-pep-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.pep_snet.id

  private_service_connection {
    name                           = "${var.project}-weu-subsmigrations-psql-pep-01"
    private_connection_resource_id = module.subscriptionmigrations_db_flex_server.id
    is_manual_connection           = false
    subresource_names              = ["postgresqlServer"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.postgres.id]
  }

  tags = var.tags
}
