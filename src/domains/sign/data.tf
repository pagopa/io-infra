data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = "io-p-vnet-common"
  resource_group_name  = "io-p-rg-common"
}

data "azurerm_subnet" "apim" {
  name                 = "apimapi"
  virtual_network_name = "io-p-vnet-common"
  resource_group_name  = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_application_insights" "application_insights" {
  name                = "io-p-ai-common"
  resource_group_name = "io-p-rg-common"
}
