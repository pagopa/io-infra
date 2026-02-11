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
