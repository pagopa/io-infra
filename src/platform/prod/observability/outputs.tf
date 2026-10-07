output "monitoring_italynorth" {
  value     = module.monitoring_italynorth
  sensitive = true
}

output "monitoring_westeurope" {
  value     = module.monitoring_westeurope
  sensitive = true
}

output "storage_accounts" {
  value = {
    weu = {
      logs = module.storage_accounts_westeurope.logs.westeurope
    }
    itn = {
      logs = module.storage_accounts_italynorth.logs.italynorth
    }
  }
  sensitive = true
}