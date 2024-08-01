output "acr" {
  value = {
    id   = module.container_registry.id
    name = module.container_registry.name
  }
}
