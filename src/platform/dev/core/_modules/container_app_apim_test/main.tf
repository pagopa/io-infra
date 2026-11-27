terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
    dx = {
      source = "pagopa-dx/azure"
    }
  }
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

module "env" {
  source  = "pagopa-dx/azure-container-app-environment/azurerm"
  version = "~> 5.0"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = var.app_name
    instance_number = "01"
  }

  use_case                   = "development"
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = var.log_analytics_workspace_id

  networking = {
    virtual_network_id            = var.virtual_network.id
    public_network_access_enabled = true
  }

  tags = var.tags
}

module "app" {
  source  = "pagopa-dx/azure-container-app/azurerm"
  version = "~> 9.1"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = var.location
    app_name        = var.app_name
    instance_number = "01"
  }

  use_case                     = "development"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = module.env.id
  log_analytics_workspace_id   = var.log_analytics_workspace_id

  deployment_strategy = "Latest"
  container_port      = 8080

  containers = [
    {
      name  = var.app_name
      image = "ghcr.io/giamma1295/apim-test:0.1.0"

      environment_variables = [
        {
          name  = "PORT"
          value = "8080"
        },
        {
          name  = "API_APP_ID_URI"
          value = one(data.azuread_application.test_apim_api.identifier_uris)
        },
        {
          name  = "APIM_API_URL"
          value = "${trimsuffix(data.azurerm_api_management.test.gateway_url, "/")}/test-apim/items"
        },
      ]

      liveness_probe = {
        path = "/api/health"
      }
    }
  ]

  tags = var.tags
}

resource "azuread_app_role_assignment" "container_app_apim_test_read" {
  app_role_id         = data.azuread_application.test_apim_api.app_role_ids["ApiRead"]
  principal_object_id = module.app.principal_id
  resource_object_id  = data.azuread_service_principal.test_apim_api.object_id
}
