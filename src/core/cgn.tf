data "azurerm_resource_group" "cgn" {
  name = format("%s-rg-cgn", local.project)
}

## redis cgn subnet
module "redis_cgn_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.26"
  name                                           = format("%s-redis-cgn-snet", local.project)
  address_prefixes                               = ["10.0.14.0/25"]
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true
}

module "redis_cgn" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.26"
  name                  = format("%s-redis-cgn-std", local.project)
  resource_group_name   = data.azurerm_resource_group.cgn.name
  location              = data.azurerm_resource_group.cgn.location
  capacity              = 1
  family                = "C"
  sku_name              = "Standard"
  enable_authentication = true

  // when azure can apply patch?
  patch_schedules = [{
    day_of_week    = "Sunday"
    start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]


  private_endpoint = {
    enabled              = true
    virtual_network_id   = data.azurerm_virtual_network.vnet_common.id
    subnet_id            = module.redis_cgn_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}

data "azurerm_subnet" "fn3cgn" {
  name                 = "fn3cgn"
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
}

##################
## CosmosDB cgn ##
##################

module "cosmos_cgn" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.18"
  name     = format("%s-cosmos-cgn", local.project)
  location = var.location

  resource_group_name = data.azurerm_resource_group.cgn.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  main_geo_location_zone_redundant = false

  enable_free_tier          = false
  enable_automatic_failover = true


  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = "westeurope"

  additional_geo_locations = [
    {
      location          = "northeurope"
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  backup_continuous_enabled = true

  is_virtual_network_filter_enabled = true

  ip_range = ""

  allowed_virtual_network_subnet_ids = [
    data.azurerm_subnet.fn3cgn.id
  ]

  # private endpoint
  private_endpoint_name    = format("%s-cosmos-cgn-sql-endpoint", local.project)
  private_endpoint_enabled = true
  subnet_id                = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids     = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]

  tags = var.tags

}

## Database
module "cgn_cosmos_db" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.15"
  name                = "db"
  resource_group_name = data.azurerm_resource_group.cgn.name
  account_name        = module.cosmos_cgn.name
}


## Blob storage due to legal backup
#tfsec:ignore:azure-storage-default-action-deny
module "cgn_legalbackup_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.79"

  name                       = replace(format("%s-cgn-legalbackup-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.cgn_legalbackup_enable_versioning
  account_replication_type   = var.cgn_legalbackup_account_replication_type
  resource_group_name        = data.azurerm_resource_group.cgn.name
  location                   = data.azurerm_resource_group.cgn.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_access_key" {
  name         = "cgn-legalbackup-storage-access-key"
  value        = module.cgn_legalbackup_storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_connection_string" {
  name         = "cgn-legalbackup-storage-connection-string"
  value        = module.cgn_legalbackup_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_blob_connection_string" {
  name         = "cgn-legalbackup-storage-blob-connection-string"
  value        = module.cgn_legalbackup_storage.primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_storage_container" "cgn_legalbackup_container" {
  name                  = "cgn-legalbackup-blob"
  storage_account_name  = module.cgn_legalbackup_storage.name
  container_access_type = "private"
}

resource "azurerm_private_endpoint" "cgn_legalbackup_storage" {
  name                = format("%s-cgn-legalbackup-storage", local.project)
  location            = data.azurerm_resource_group.cgn.location
  resource_group_name = data.azurerm_resource_group.cgn.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-cgn-legalbackup-storage-private-endpoint", local.project)
    private_connection_resource_id = module.cgn_legalbackup_storage.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
  }
}

## Api merchant
module "apim_product_merchant" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.1.20"

  product_id   = "cgnmerchant"
  display_name = "IO CGN API MERCHANT"
  description  = "Product for CGN Merchant Api"

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/cgn/policy.xml")
}

module "api_cgn_merchant" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.19"

  name                = "io-cgn-merchant-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  product_ids         = [module.apim_product_merchant.product_id]
  // version_set_id        = azurerm_api_management_api_version_set.io_backend_bpd_api.id
  // api_version           = "v1"
  service_url = local.apim_io_backend_api.service_url

  description           = "CGN MERCHANT API for IO platform."
  display_name          = "IO CGN MERCHANT API"
  path                  = "api/v1/merchant/cgn"
  protocols             = ["http", "https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/cgn/swagger.json.tmpl",
    {
      host = "api.io.italia.it"
    }
  )

  xml_content = file("./api/cgn/policy.xml")
}

## App registration for cgn backend portal ## 

/*
### cgnonboardingportal user identity
data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = data.azurerm_key_vault.common.id
}
*/

locals {
  cgn_app_registreation_name = "cgn-onboarding-portal-backend"
}
resource "azuread_application" "cgn_onboarding_portal" {
  count                   = var.env_short == "p" ? 1 : 0
  display_name            = local.cgn_app_registreation_name
  prevent_duplicate_names = true
  identifier_uris         = [format("http://%s", local.cgn_app_registreation_name)]
  sign_in_audience        = "AzureADMyOrg"

  api {

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access cgn-onboarding-portal-backend on behalf of the signed-in user."
      admin_consent_display_name = "Access cgn-onboarding-portal-backend"
      enabled                    = true
      id                         = "100361db-cca3-447a-82ea-af00e8fdc0b7"
      type                       = "User"
      user_consent_description   = "Allow the application to access cgn-onboarding-portal-backend on your behalf."
      user_consent_display_name  = "Access cgn-onboarding-portal-backend"
      value                      = "user_impersonation"
    }

  }

  web {
    redirect_uris = []
    homepage_url  = format("https://%s", local.cgn_app_registreation_name)
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }
}

resource "azuread_service_principal" "cgn_onboarding_portal" {
  count          = var.env_short == "p" ? 1 : 0
  application_id = azuread_application.cgn_onboarding_portal[0].application_id
}

resource "azurerm_role_assignment" "service_contributor" {
  count                = var.env_short == "p" ? 1 : 0
  scope                = module.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = azuread_service_principal.cgn_onboarding_portal[0].id
  # principal_id = azuread_application.cgn_onboarding_portal[0].application_id
}