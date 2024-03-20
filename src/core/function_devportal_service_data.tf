locals {
  function_devportalservicedata = {
    app_context = {
      resource_group_name = data.azurerm_resource_group.selfcare_be_rg
    }

    db = {
      name = "${local.project}-devportalservicedata-db-postgresql"
    }
  }
}

#
# DB
#

data "azurerm_key_vault_secret" "devportalservicedata_db_server_fndevportalservicedata_password" {
  name         = "devportal-servicedata-FNDEVPORTALSERVICEDATA-PASSWORD"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportalservicedata_db_server_adm_password" {
  name         = "devportal-servicedata-DB-ADM-PASSWORD"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportalservicedata_db_server_adm_username" {
  name         = "devportal-servicedata-DB-ADM-USERNAME"
  key_vault_id = module.key_vault_common.id
}


module "devportalservicedata_db_server" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//postgres_flexible_server?ref=v7.61.0"

  name                = local.function_devportalservicedata.db.name
  location            = var.location
  resource_group_name = local.function_devportalservicedata.app_context.resource_group_name

  administrator_login    = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_username.value
  administrator_password = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_password.value

  sku_name                     = "GP_Standard_D2s_v3"
  db_version                   = 13
  geo_redundant_backup_enabled = true
  zone                         = 1

  private_endpoint_enabled = true
  private_dns_zone_id      = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id
  delegated_subnet_id      = data.azurerm_subnet.devportal_service_data_snet.id

  high_availability_enabled = false

  pgbouncer_enabled = true

  storage_mb = 32768 # 32GB

  alerts_enabled = true

  diagnostic_settings_enabled = false

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "devportalservicedata_db" {
  name       = "db"
  server_id  = module.devportalservicedata_db_server.id
  charset    = "UTF8"
  collation  = "en_US.utf8"
  depends_on = [module.devportalservicedata_db_server]
}

data "azurerm_subnet" "devportal_service_data_snet" {
  name                 = "${local.project}-devportalservicedata-db-postgresql-snet"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
}

data "azurerm_linux_web_app" "appservice_devportal_be" {
  name                = "${local.project}-app-devportal-be"
  resource_group_name = "${local.project}-selfcare-be-rg"
}
