output "services_snet" { #TODO this probably does not work should be an array maybe?
  value = {
    id   = module.services_snet.id
    name = module.services_snet.name
  }
}
