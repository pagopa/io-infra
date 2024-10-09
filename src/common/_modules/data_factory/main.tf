resource "azurerm_data_factory" "this" {
  name                = "io-p-data-factory"
  resource_group_name = "io-p-rg-operations"
  location            = "westeurope"

  # identity {
  #   type = "SystemAssigned,UserAssigned"

  #   user_assigned_identity {
  #     id = 
  #   }
  # }

  public_network_enabled = false

  tags = {}
}

resource "azurerm_user_assigned_identity" "data_factory_identity" {
  name                = "io-p-data-factory"
  resource_group_name = "io-p-rg-operations"
  location            = "westeurope"
}