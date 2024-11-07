#
# MANAGED IDENTITIES
#

data "azurerm_user_assigned_identity" "managed_identity_io_infra_ci" {
  name                = "${local.product}-infra-github-ci-identity"
  resource_group_name = "${local.product}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_cd" {
  name                = "${local.product}-infra-github-cd-identity"
  resource_group_name = "${local.product}-identity-rg"
}

# azure storage account existing resource group
data "azurerm_resource_group" "core_ext" {
  name = format("%s-citizen-auth-data-rg", local.product)
}

data "azurerm_virtual_network" "vnet_itn" {
  name                = "${local.prefix}-${local.env_short}-itn-common-vnet-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_pep_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}