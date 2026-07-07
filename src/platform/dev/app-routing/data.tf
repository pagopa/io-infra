data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

# Managed Identities

data "azurerm_user_assigned_identity" "managed_identity_io_infra_ci" {
  name                = "${local.prefix}-${local.env_short}-infra-github-ci-identity"
  resource_group_name = "${local.prefix}-${local.env_short}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-infra-github-cd-identity"
  resource_group_name = "${local.prefix}-${local.env_short}-identity-rg"
}

# RG

data "azurerm_resource_group" "itn_common" {
  name = "io-d-itn-common-rg-01"
}

# VNET

data "azurerm_virtual_network" "itn_common" {
  name                = "io-d-itn-common-vnet-01"
  resource_group_name = data.azurerm_resource_group.itn_common.name
}

# Application Insight

data "azurerm_application_insights" "itn_ai" {
  name                = "io-d-ai-common"
  resource_group_name = "io-d-rg-common"
}

# KV

data "azurerm_key_vault" "itn_common" {
  name                = "io-d-itn-common-kv-01"
  resource_group_name = data.azurerm_resource_group.itn_common.name
}
