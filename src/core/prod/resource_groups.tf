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
