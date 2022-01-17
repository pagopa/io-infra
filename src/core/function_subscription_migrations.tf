locals {
  function_subscriptionmigrations = {
    app_settings_commons = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"
    }

    // As we run this application under SelfCare IO logic subdomain,
    //  we share some resources
    app_context = {
      name             = "subsmigrations"
      resource_group   = azurerm_resource_group.selfcare_be_rg
      app_service_plan = azurerm_app_service_plan.selfcare_be_common
      snet             = module.selfcare_be_common_snet
    }
  }
}

module "function_subscriptionmigrations" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.1.11"

  name                = format("%s-%s-fn", local.project, local.function_subscriptionmigrations.app_context.name)
  location            = local.function_subscriptionmigrations.app_context.resource_group.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
  }

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "api/v1/info"

  subnet_id   = local.function_subscriptionmigrations.app_context.snet.id
  allowed_ips = local.app_insights_ips_west_europe
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {})

  tags = var.tags
}


module "function_subscriptionmigrations_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.1.11"

  name                = "staging"
  location            = local.function_subscriptionmigrations.app_context.resource_group.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  function_app_name   = module.function_subscriptionmigrations.name
  function_app_id     = module.function_subscriptionmigrations.id
  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  storage_account_name               = module.function_subscriptionmigrations.storage_account_name
  storage_account_access_key         = module.function_subscriptionmigrations.storage_account.primary_access_key
  internal_storage_connection_string = module.function_subscriptionmigrations.storage_account_internal_function.primary_connection_string

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "api/v1/info"

  subnet_id   = local.function_subscriptionmigrations.app_context.snet.id
  allowed_ips = concat(
    [],
  )
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {})

  tags = var.tags
}

#
# DB
#

data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_adm_username" {
  name         = "selfcare-subsmigrations-DB-ADM-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_adm_password" {
  name         = "selfcare-subsmigrations-DB-ADM-PASSWORD"
  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_postgresql_server" "subscriptionmigrations_db_server" {
  name                = format("%s-%s-db-postgresql", local.project, local.function_subscriptionmigrations.app_context.name)
  location            = var.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name

  administrator_login          = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_username.value
  administrator_login_password = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_password.value

  sku_name   = "GP_Gen5_2"
  version    = 11
  storage_mb = 5120 # 5GB

  auto_grow_enabled = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  tags = var.tags

}


resource "azurerm_postgresql_database" "subscriptionmigrations_database" {
  name                = format("%s%s", local.project, local.function_subscriptionmigrations.app_context.name)
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  server_name         = azurerm_postgresql_server.subscriptionmigrations_db_server.name
  charset             = "UTF8"
  collation           = "Italian_Italy.1252"
}

resource "azurerm_private_endpoint" "subscriptionmigrations_postgresql_private_endpoint" {
  name                = format("%s-%s-db-private-endpoint", local.project, local.function_subscriptionmigrations.app_context.name)
  location            = var.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  subnet_id           = module.subnet_db.id

  private_dns_zone_group {
    name                 = format("%s-%s-db-private-dns-zone-group", local.project, local.function_subscriptionmigrations.app_context.name)
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_postgres.id]
  }

  private_service_connection {
    name                           = format("%s-%s-db-private-service-connection", local.project, local.function_subscriptionmigrations.app_context.name)
    private_connection_resource_id = azurerm_postgresql_server.subscriptionmigrations_db_server.id
    is_manual_connection           = false
    subresource_names              = ["postgreSqlServer"]
  }
}

resource "azurerm_private_dns_a_record" "private_dns_a_record_postgresql" {
  name                = format("%s%spostgresql", local.project, local.function_subscriptionmigrations.app_context.name)
  zone_name           = azurerm_private_dns_zone.private_dns_zone_postgres.name
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  ttl                 = 300
  records             = azurerm_private_endpoint.subscriptionmigrations_postgresql_private_endpoint.private_service_connection.*.private_ip_address
}
