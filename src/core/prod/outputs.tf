output "networking" {
  value = {
    itn = module.networking_itn
    weu = module.networking_weu
  }
}

output "key_vault" {
  value = {
    itn = null
    weu = module.key_vault_weu
  }
}

output "global" {
  value = module.global
}