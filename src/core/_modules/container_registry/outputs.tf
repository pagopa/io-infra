output "acr" {
  value = {
    id           = module.container_registry.id
    login_server = module.container_registry.login_server
  }
}
