output "services_snet" {
  value = [
    for snet in module.services_snet : {
      id   = snet.id
      name = snet.name
    }
  ]
}
