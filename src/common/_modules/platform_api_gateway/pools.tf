locals {
  app_backend_pool_name = "app-backend-pool"
}

resource "azurerm_api_management_backend" "app_backend_backends" {
  count               = length(var.app_backend_urls)
  title               = "App Backend ${count.index + 1}"
  name                = "app-backend-${count.index + 1}"
  resource_group_name = var.resource_group_internal
  api_management_name = module.platform_api_gateway.name
  protocol            = "http"
  url                 = var.app_backend_urls[count.index]
}

resource "azapi_resource" "app_backend_pool" {
  type      = "Microsoft.ApiManagement/service/backends@2024-06-01-preview"
  name      = local.app_backend_pool_name
  parent_id = module.platform_api_gateway.id
  body = {
    properties = {
      protocol    = null
      url         = null
      type        = "Pool"
      description = "Load Balancer of App Backend"
      pool = {
        services = [
          for backend in azurerm_api_management_backend.app_backend_backends : {
            id = backend.id
          }
        ]
      }
    }
  }
}