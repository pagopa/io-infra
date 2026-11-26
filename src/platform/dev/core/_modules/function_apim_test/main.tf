terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
    dx = {
      source = "pagopa-dx/azure"
    }
  }
}

data "azurerm_subnet" "itn_pep" {
  name                 = var.private_endpoint_subnet_name
  virtual_network_name = var.virtual_network.name
  resource_group_name  = var.virtual_network.resource_group_name
}

data "azurerm_api_management" "test" {
  name                = var.api_management.name
  resource_group_name = var.api_management.resource_group_name
}

data "azuread_application" "test_apim_api" {
  display_name = var.api_application_display_name
}

data "azuread_service_principal" "test_apim_api" {
  client_id = data.azuread_application.test_apim_api.client_id
}

resource "dx_available_subnet_cidr" "function_apim_test" {
  virtual_network_id = var.virtual_network.id
  prefix_length      = 26
}

module "app" {
  source  = "pagopa-dx/azure-function-app/azurerm"
  version = "~> 7.1"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = "apimtest"
    instance_number = "01"
  }
  resource_group_name = var.resource_group_name

  virtual_network      = var.virtual_network
  subnet_cidr          = dx_available_subnet_cidr.function_apim_test.cidr_block
  subnet_pep_id        = data.azurerm_subnet.itn_pep.id
  private_dns_zone_ids = var.private_dns_zone_ids

  stack             = "node"
  node_version      = 22
  health_check_path = "/api/health"

  app_settings = {
    API_APP_ID_URI = one(data.azuread_application.test_apim_api.identifier_uris)
    APIM_API_URL   = "${trimsuffix(data.azurerm_api_management.test.gateway_url, "/")}/test-apim/items"
  }

  tags = var.tags
}

resource "azuread_app_role_assignment" "function_apim_test_read" {
  app_role_id         = data.azuread_application.test_apim_api.app_role_ids["ApiRead"]
  principal_object_id = module.app.function_app.function_app.principal_id
  resource_object_id  = data.azuread_service_principal.test_apim_api.object_id
}

output "name" {
  description = "Name of the private Function App for the APIM smoke test."
  value       = module.app.function_app.function_app.name
}
