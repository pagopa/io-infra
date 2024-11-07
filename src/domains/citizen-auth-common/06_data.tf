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

# ITN LOLLIPOP FUNCTION
data "azurerm_resource_group" "lollipop_function_rg" {
  name = format("%s-itn-lollipop-rg-01", local.product)
}

data "azurerm_linux_function_app" "lollipop_function" {
  name                = format("%s-itn-lollipop-fn-01", local.product)
  resource_group_name = data.azurerm_resource_group.lollipop_function_rg.name
}
#######################

data "azurerm_virtual_network" "vnet_itn" {
  name                = "${var.prefix}-${var.env_short}-itn-common-vnet-01"
  resource_group_name = "${var.prefix}-${var.env_short}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_pep_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}