output "cdn_selfcare" {
  value = {
    id                  = module.cdn_selfcare.id
    resource_group_name = var.resource_group_name
  }
}
