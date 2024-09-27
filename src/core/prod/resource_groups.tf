resource "azurerm_resource_group" "common_itn" {
  name     = "${local.project_itn}-common-rg-01"
  location = "italynorth"

  tags = local.tags
}

moved {
  from = azurerm_resource_group.vnet
  to   = azurerm_resource_group.common_itn
}

resource "azurerm_resource_group" "dashboards_itn" {
  name     = "${local.project_itn}-common-dashboards-rg-01"
  location = "italynorth"

  tags = local.tags
}

# Important: do not create any resource inside this resource group
resource "azurerm_resource_group" "role_assignment_itn" {
  name     = "default-roleassignment-rg"
  location = "italynorth"

  tags = local.tags
}

resource "azurerm_resource_group" "github_managed_identity_itn" {
  name     = "${local.project_itn}-github-id-rg-01"
  location = "italynorth"

  tags = local.tags
}

resource "azurerm_resource_group" "internal_weu" {
  name     = format("%s-rg-internal", local.project_weu_legacy)
  location = "westeurope"

  tags = local.tags
}

resource "azurerm_resource_group" "external_weu" {
  name     = format("%s-rg-external", local.project_weu_legacy)
  location = "westeurope"

  tags = local.tags
}

resource "azurerm_resource_group" "common_weu" {
  name     = format("%s-rg-common", local.project_weu_legacy)
  location = "westeurope"

  tags = local.tags
}

resource "azurerm_resource_group" "sec_weu" {
  name     = format("%s-sec-rg", local.project_weu_legacy)
  location = "westeurope"

  tags = local.tags
}

resource "azurerm_resource_group" "acr_weu" {
  name     = format("%s-container-registry-rg", local.project_weu_legacy)
  location = "westeurope"

  tags = local.tags
}

moved {
  from = module.container_registry.azurerm_resource_group.container_registry
  to   = azurerm_resource_group.acr_weu
}

resource "azurerm_resource_group" "assets_cdn_weu" {
  name     = format("%s-assets-cdn-rg", local.project_weu_legacy)
  location = "westeurope"

  tags = local.tags
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-assets-cdn-rg"
  to = azurerm_resource_group.assets_cdn_weu
}

resource "azurerm_resource_group" "linux_weu" {
  name     = "${local.project_weu_legacy}-rg-linux"
  location = "westeurope"

  tags = local.tags
}

import {
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-linux"
  to = azurerm_resource_group.linux_weu
}
