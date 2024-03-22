output "subnet_eucovidcert" {
  value = {
    id   = module.function_eucovidcert_snet.id
    name = module.function_eucovidcert_snet.name
  }
}
