output "dns" {
  value = module.dns
}

output "private_endpoints" {
  value = {
    itn = module.private_endpoints_itn.private_endpoints
  }
}