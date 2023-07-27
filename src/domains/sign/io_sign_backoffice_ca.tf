resource "azurerm_container_app" "io_sign_backoffice_ca" {
  name                         = format("%s-backoffice-ca", local.project)
  container_app_environment_id = module.io_sign_container_app_environment.id
  resource_group_name          = azurerm_resource_group.backend_rg.name
  revision_mode                = "Single"

  ingress {
    external_enabled = false
  }
  template {
    container {
      name   = "webapp"
      image  = "ghcr.io/pagopa/io-sign-backoffice:latest"
      cpu    = var.io_sign_backoffice_ca.cpu
      memory = var.io_sign_backoffice_ca.memory
      dynamic "env" {
        for_each = var.io_sign_backoffice_ca.env
        content {
          name        = env.value.name
          secret_name = env.value.secret_name
          value       = env.value.value
        }
      }
    }
  }
  tags = var.tags
}
