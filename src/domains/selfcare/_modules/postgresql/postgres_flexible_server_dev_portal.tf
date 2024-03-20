module "devportalservicedata_db_server" {
  source = "github.com/pagopa/terraform-azurerm-v3//postgres_flexible_server?ref=v7.69.1"

  name                = "${var.project}-devportalservicedata-db-postgresql"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login    = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_username.value
  administrator_password = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_password.value

  sku_name                     = "GP_Standard_D2s_v3"
  db_version                   = 13
  geo_redundant_backup_enabled = true
  zone                         = 1

  private_endpoint_enabled = true
  private_dns_zone_id      = data.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id
  delegated_subnet_id      = var.dev_portal_subnet_id

  high_availability_enabled = false

  pgbouncer_enabled = true

  storage_mb = 32768 # 32GB

  alerts_enabled = true

  diagnostic_settings_enabled = false

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "devportalservicedata_db" {
  name      = "db"
  server_id = module.devportalservicedata_db_server.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
