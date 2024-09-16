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

output "azure_devops_agent" {
  value = {
      weu = module.azdoa_weu
      itn = null
  }
}