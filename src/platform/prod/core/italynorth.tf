module "custom_roles" {
  source  = "pagopa-dx/azure-core-infra/azurerm//modules/custom_roles"
  version = "~> 4.2"
}

module "private_endpoints_itn" {
  source = "./_modules/private_endpoint"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = local.core.resource_groups.italynorth.common

  pep_snet_id = local.core.networking.itn.pep_snet.id
  dns_zones   = module.dns.zones.private_dns_zones

  tags = local.tags
}

module "storage_accounts_itn" {
  source = "./_modules/storage_accounts"

  location                  = "italynorth"
  project                   = local.project_itn
  subscription_id           = data.azurerm_subscription.current.subscription_id
  resource_group_common     = local.core.resource_groups.italynorth.common
  resource_group_operations = local.core.resource_groups.westeurope.operations

  azure_adgroup_com_admins_object_id = data.azuread_group.com_admins.object_id
  azure_adgroup_com_devs_object_id   = data.azuread_group.com_devs.object_id
  azure_adgroup_admins_object_id     = data.azuread_group.admins.object_id

  tags = local.tags
}
