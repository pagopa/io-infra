data "azurerm_client_config" "current" {}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_ci" {
  name                = "${local.prefix}-${local.env_short}-infra-github-ci-identity"
  resource_group_name = "${local.prefix}-${local.env_short}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_cd" {
  name                = "${local.prefix}-${local.env_short}-infra-github-cd-identity"
  resource_group_name = "${local.prefix}-${local.env_short}-identity-rg"
}

# Common KV

data "azurerm_key_vault" "itn_common" {
  name                = "io-d-itn-common-kv-01"
  resource_group_name = "${local.prefix}-d-${local.location_short.italynorth}-common-rg-01"
}