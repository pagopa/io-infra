output "private_endpoints" {
  value = {
    for k, v in azurerm_private_endpoint.this :
    k => {
      name = v.name
      id   = v.id
    }
  }
}