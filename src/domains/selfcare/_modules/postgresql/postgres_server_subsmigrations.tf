module "subscriptionmigrations_db_server" {
  source = "github.com/pagopa/terraform-azurerm-v3//postgresql_server?ref=v7.69.1"

  name                = "${var.project}-subsmigrations-db-postgresql"
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_username.value
  administrator_login_password = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_password.value

  sku_name                     = "GP_Gen5_2"
  db_version                   = 11
  geo_redundant_backup_enabled = false

  public_network_access_enabled = false
  private_endpoint = {
    enabled              = true
    virtual_network_id   = var.vnet_id
    subnet_id            = var.private_endpoint_subnet_id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id]
  }

  alerts_enabled                = true
  monitor_metric_alert_criteria = local.subsmigrations.db.metric_alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]

  lock_enable = true

  tags = var.tags
}

resource "azurerm_postgresql_database" "selfcare_subscriptionmigrations_db" {
  name                = "db"
  resource_group_name = var.resource_group_name
  server_name         = module.subscriptionmigrations_db_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
