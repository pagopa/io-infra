module "function_subscriptionmigrations" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.69.1"

  name                    = "${var.project}-subsmigrations-fn"
  location                = var.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = azurerm_service_plan.selfcare_be_common.id
  system_identity_enabled = true

  application_insights_instrumentation_key = var.app_insights_key

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = var.private_endpoint_subnet_id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core.id],
    "queues" = [
      local.function_subscriptionmigrations.app_settings.QUEUE_ADD_SERVICE_TO_MIGRATIONS,
      local.function_subscriptionmigrations.app_settings.QUEUE_ALL_SUBSCRIPTIONS_TO_MIGRATE,
      local.function_subscriptionmigrations.app_settings.QUEUE_SUBSCRIPTION_TO_MIGRATE,
    ],
    "containers"           = [],
    "blobs_retention_days" = 1,
  }

  runtime_version   = "~3"
  health_check_path = "/api/v1/info"
  node_version      = "14"

  subnet_id   = var.subnet_id
  allowed_ips = var.app_insights_ips
  allowed_subnets = [
    # self hosted runners subnet
    data.azurerm_subnet.self_hosted_runner_snet.id,
    #
    var.subnet_id,
    data.azurerm_subnet.services_cms_backoffice_snet_itn.id
  ]

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true

  }

  app_settings = merge(local.function_subscriptionmigrations.app_settings, {
    // those are slot configs
    "AzureWebJobs.OnServiceChange.Disabled"                 = "0"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "0"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "0"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "0"
  })

  sticky_app_setting_names = [
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled",
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled",
    "AzureWebJobs.OnServiceChange.Disabled",
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"
  ]

  tags = var.tags
}

module "function_subscriptionmigrations_staging_slot" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.69.1"

  name                    = "staging"
  location                = var.location
  resource_group_name     = module.function_subscriptionmigrations.resource_group_name
  function_app_id         = module.function_subscriptionmigrations.id
  app_service_plan_id     = azurerm_service_plan.selfcare_be_common.id
  system_identity_enabled = true

  application_insights_instrumentation_key = var.app_insights_key

  storage_account_name               = module.function_subscriptionmigrations.storage_account_name
  storage_account_access_key         = module.function_subscriptionmigrations.storage_account.primary_access_key
  internal_storage_connection_string = module.function_subscriptionmigrations.storage_account_internal_function.primary_connection_string

  runtime_version   = "~3"
  health_check_path = "/api/v1/info"
  node_version      = "14"
  always_on         = "true"

  subnet_id = var.subnet_id
  allowed_ips = concat(
    [],
  )
  allowed_subnets = [
    # self hosted runners subnet
    data.azurerm_subnet.self_hosted_runner_snet.id,
    #
    data.azurerm_subnet.snet_azdoa.id
  ]

  app_settings = merge(local.function_subscriptionmigrations.app_settings, {
    // disable listeners on staging slot
    "AzureWebJobs.OnServiceChange.Disabled"                 = "1"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "1"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "1"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "1"
  })

  tags = var.tags
}

resource "azurerm_private_endpoint" "function_sites" {
  name                = "${var.project}-subsmigrations-fn"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.project}-subsmigrations-fn"
    private_connection_resource_id = module.function_subscriptionmigrations.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_sites" {
  name                = "${var.project}-subsmigrations-fn-staging"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.project}-subsmigrations-fn-staging"
    private_connection_resource_id = module.function_subscriptionmigrations.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_subscriptionmigrations_staging_slot.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}
