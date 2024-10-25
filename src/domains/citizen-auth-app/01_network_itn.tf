## itn-common vnet
data "azurerm_resource_group" "italy_north_common_rg" {
  name = format("%s-itn-common-rg-01", local.product)
}

data "azurerm_virtual_network" "common_vnet_italy_north" {
  name                = format("%s-itn-common-vnet-01", local.product)
  resource_group_name = data.azurerm_resource_group.italy_north_common_rg.name
}

data "azurerm_subnet" "itn_pep" {
  name                 = "${local.common_project_itn}-pep-snet-01"
  virtual_network_name = data.azurerm_virtual_network.common_vnet_italy_north.name
  resource_group_name  = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
}

module "fn_profile_snet" {
  count                                     = var.function_profile_count
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.44.0"
  name                                      = format("%s-profile-snet-0%d", local.short_project_itn, count.index + 1)
  address_prefixes                          = [var.cidr_subnet_profile_itn[count.index]]
  resource_group_name                       = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.common_vnet_italy_north.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "fn_profile_async_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.44.0"
  name                                      = format("%s-profile-async-snet-01", local.short_project_itn)
  address_prefixes                          = var.cidr_subnet_profile_async_itn
  resource_group_name                       = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.common_vnet_italy_north.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

#########################
# Private Endpoints
#########################

## fn-lollipop-itn

resource "azurerm_private_endpoint" "function_lollipop_itn_sites" {
  name                = "${local.common_project_itn}-lollipop-fn-pep-01"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-lollipop-fn-pep-01"
    private_connection_resource_id = module.function_lollipop_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_lollipop_itn_sites" {
  name                = "${local.common_project}-lollipop-fn-staging-pep-01"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-lollipop-fn-staging-app-pep-01"
    private_connection_resource_id = module.function_lollipop_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_lollipop_staging_slot_itn.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

## fn-fast-login-itn

resource "azurerm_private_endpoint" "function_fast_login_itn_sites" {
  name                = "${local.common_project_itn}-fast-login-fn-pep-01"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.fast_login_rg_itn.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-fast-login-fn-pep-01"
    private_connection_resource_id = module.function_fast_login_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  depends_on = [module.function_fast_login_itn]

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_fast_login_itn_sites" {
  name                = "${local.common_project_itn}-fast-login-fn-staging-pep-01"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.fast_login_rg_itn.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-fast-login-fn-staging-pep-01"
    private_connection_resource_id = module.function_fast_login_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_fast_login_staging_slot_itn.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  depends_on = [module.function_fast_login_itn, module.function_fast_login_staging_slot_itn]

  tags = var.tags
}

## itn-profile-fn

resource "azurerm_private_endpoint" "function_profile_itn_sites" {
  count               = var.function_profile_count
  name                = format("%s-profile-pep-0%d", local.common_project_itn, count.index + 1)
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.function_profile_rg[count.index].name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = format("%s-profile-pep-0%d", local.common_project_itn, count.index + 1)
    private_connection_resource_id = module.function_profile[count.index].id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_profile_itn_sites" {
  count               = var.function_profile_count
  name                = format("%s-profile-staging-pep-0%d", local.common_project_itn, count.index + 1)
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.function_profile_rg[count.index].name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = format("%s-profile-staging-pep-0%d", local.common_project_itn, count.index + 1)
    private_connection_resource_id = module.function_profile[count.index].id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_profile_staging_slot[count.index].name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

## itn-profile-async-fn

resource "azurerm_private_endpoint" "function_profile_async_itn_sites" {
  name                = format("%s-profile-async-pep-01", local.common_project_itn)
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.function_profile_async_rg.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = format("%s-profile-async-pep-01", local.common_project_itn)
    private_connection_resource_id = module.function_profile_async.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_profile_async_itn_sites" {
  name                = format("%s-profile-async-staging-pep-01", local.common_project_itn)
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.function_profile_async_rg.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = format("%s-profile-async-staging-pep-01", local.common_project_itn)
    private_connection_resource_id = module.function_profile_async.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_profile_async_staging_slot.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  tags = var.tags
}

## fn-public-itn pep
resource "azurerm_private_endpoint" "function_public_itn_sites" {
  name                = "${local.common_project_itn}-public-func-pep-01"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.shared_rg_itn.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-public-func-pep-01"
    private_connection_resource_id = module.function_public_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  depends_on = [module.function_public_itn]

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_public_itn_sites" {
  name                = "${local.common_project_itn}-fast-login-func-staging-pep-01"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.shared_rg_itn.name
  subnet_id           = data.azurerm_subnet.itn_pep.id

  private_service_connection {
    name                           = "${local.common_project_itn}-public-func-staging-pep-01"
    private_connection_resource_id = module.function_public_itn.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.function_public_staging_slot_itn.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurewebsites_net.id]
  }

  depends_on = [module.function_public_itn, module.function_public_staging_slot_itn]

  tags = var.tags
}
