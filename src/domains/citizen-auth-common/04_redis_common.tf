
/**
* [REDIS V6]
*/
data "azurerm_resource_group" "data_rg_itn" {
  name = "${local.project_itn}-data-rg-01"
}

