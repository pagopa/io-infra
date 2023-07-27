resource "azurerm_container_app" "io_sign_backoffice_ca" {
  name                         = format("%s-backoffice-ca", local.project)
  container_app_environment_id = azurerm_container_app_environment.io_sign_cae.id
  resource_group_name          = azurerm_resource_group.backend_rg.name
  revision_mode                = "Single"

  ingress {
    external_enabled = false
  }

  registry {
    server               = "ghcr.io"
    username             = "strategic-innovation-bot"
    password_secret_name = "ghcr-registry-password"
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
