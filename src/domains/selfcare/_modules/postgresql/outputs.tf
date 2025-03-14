output "dev_portal_db" {
  value = {
    id       = module.devportalservicedata_db_server.id
    name     = module.devportalservicedata_db_server.name
    database = azurerm_postgresql_flexible_server_database.devportalservicedata_db.id
  }
}

output "dev_portal_db_credentials" {
  value = {
    host     = module.devportalservicedata_db_server.fqdn
    username = module.devportalservicedata_db_server.administrator_login
    password = module.devportalservicedata_db_server.administrator_password
  }
  sensitive = true
}

output "subsmigrations_db" {
  value = {
    id   = module.subscriptionmigrations_db_flex_server.id
    name = module.subscriptionmigrations_db_flex_server.name
  }
}

output "subsmigrations_db_credentials" {
  value = {
    host     = module.subscriptionmigrations_db_flex_server.fqdn
    username = module.subscriptionmigrations_db_flex_server.administrator_login
    password = module.subscriptionmigrations_db_flex_server.administrator_password
  }
  sensitive = true
}
