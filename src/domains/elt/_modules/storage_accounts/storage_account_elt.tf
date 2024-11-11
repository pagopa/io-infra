#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "storage_account_elt" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.67.1"

  name                = replace(format("%s-stelt", var.project), "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "GZRS"
  access_tier                   = "Hot"
  advanced_threat_protection    = true
  public_network_access_enabled = true

  blob_versioning_enabled  = true
  blob_change_feed_enabled = true

  tags = var.tags
}

module "storage_account_itn_elt" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.67.1"

  name                = replace(format("%s-elt-st-01", var.project_itn), "-", "")
  resource_group_name = var.resource_group_name_itn
  location            = var.location

  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  access_tier                   = "Hot"
  public_network_access_enabled = true

  blob_versioning_enabled  = true
  blob_change_feed_enabled = true

  advanced_threat_protection    = false
  enable_low_availability_alert = false

  tags = var.tags
}

module "storage_account_itn_elt_02" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.67.1"

  name                = replace(format("%s-elt-st-02", var.project_itn), "-", "")
  resource_group_name = var.resource_group_name_itn
  location            = var.location_itn

  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "ZRS"
  access_tier                   = "Hot"
  public_network_access_enabled = true

  blob_versioning_enabled = true

  advanced_threat_protection    = false
  enable_low_availability_alert = false

  tags = var.tags
}


resource "azurerm_storage_container" "messages_step_final_itn" {
  name                  = "messages-report-step-final"
  storage_account_name  = module.storage_account_itn_elt.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "messages_step_final_itn_02" {
  name                  = "messages-report-step-final"
  storage_account_name  = module.storage_account_itn_elt_02.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "messages_report_step1_itn" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_itn_elt.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "messages_report_step1_itn_02" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_itn_elt_02.name
  container_access_type = "private"
}

resource "azurerm_storage_table" "fnelterrors_itn" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fnelterrors_itn_02" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_itn_elt_02.name
}

resource "azurerm_storage_table" "fnelterrors_messages_itn" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fnelterrors_messages_itn_02" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_itn_elt_02.name
}

resource "azurerm_storage_table" "fnelterrors_message_status_itn" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fnelterrors_message_status_itn_02" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_itn_elt_02.name
}

resource "azurerm_storage_table" "fnelterrors_notification_status_itn" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fnelterrors_notification_status_itn_02" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_itn_elt_02.name
}

resource "azurerm_storage_table" "fneltcommands_itn" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fneltcommands_itn_02" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_itn_elt_02.name
}

resource "azurerm_storage_table" "fneltexports_itn" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_itn_elt.name
}

resource "azurerm_storage_table" "fneltexports_itn_02" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_itn_elt_02.name
}

module "storage_account_elt_itn" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  environment                          = local.itn_environment
  resource_group_name                  = var.resource_group_name_itn
  tier                                 = "l"
  subnet_pep_id                        = module.common_values.pep_subnets.itn.id
  private_dns_zone_resource_group_name = module.common_values.resource_groups.weu.common

  subservices_enabled = {
    blob  = true
    file  = false
    queue = false
    table = true
  }
  blob_features = {
    immutability_policy = {
      enabled = false
    }
    versioning = true
    change_feed = {
      enabled = true
    }
  }


  force_public_network_access_enabled = true

  tags = var.tags
}