module "storage_account_itn_elt" {
  source  = "pagopa-dx/azure-storage-account/azurerm"
  version = "~> 2.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location_itn
    app_name        = "elt"
    instance_number = "02"
  }
  resource_group_name = var.resource_group_name
  use_case            = "default"
  subnet_pep_id       = data.azurerm_subnet.private_endpoints_subnet_itn.id

  subservices_enabled = {
    blob  = true
    queue = true
    table = true
  }

  containers = [{
    name        = "messages-report-step-final"
    access_type = "private"
    },
    {
      name        = "messages-report-step1"
      access_type = "private"
  }]

  tables = [
    "fnelterrors",
    "fnelterrorsMessages",
    "fnelterrorsMessageStatus",
    "fnelterrorsNotificationStatus",
    "fneltcommands",
    "fneltexports",
  ]

  blob_features = {
    versioning = true
    change_feed = {
      enabled = true
    }
  }

  action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = var.tags
}
