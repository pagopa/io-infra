moved {
  from = module.selfcare_cdn.azurerm_dns_a_record.hostname[0]
  to   = module.selfcare_cdn.azurerm_dns_a_record.apex_hostname[0]
}

moved {
  from = module.selfcare_cdn.azurerm_dns_cname_record.cdnverify[0]
  to   = module.selfcare_cdn.azurerm_dns_cname_record.apex_cdnverify[0]
}

moved {
  from = module.selfcare_cdn.null_resource.custom_domain
  to   = module.selfcare_cdn.null_resource.apex_custom_hostname[0]
}
