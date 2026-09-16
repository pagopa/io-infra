# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_custom_domain.logos_custom_domain

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_endpoint.logos_endpoint

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_origin_group.logos_origin_group

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_origin.logos_origin

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_route.logos_route

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_rule_set.logos_ruleset

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_rule.caching_rules

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_rule.global_cache

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_rule.logos_global_cache

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_rule.redirect_rules

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_cdn_frontdoor_rule.sign_origin

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_dns_cname_record.logos_custom_domain_dns_record

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.azurerm_dns_txt_record.logos_custom_domain_validation_txt_record

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain_association.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_endpoint.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_origin_group.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_origin.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_profile.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_route.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_cdn_frontdoor_rule_set.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_dns_cname_record.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_dns_txt_record.validation

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.azure_cdn.azurerm_monitor_diagnostic_setting.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.cdn_storage.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.cdn_storage.azurerm_security_center_storage_defender.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.cdn_storage.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.assets_locales_cdn.module.storage_account_permissions.module.storage_account.azurerm_role_assignment.blob

  lifecycle {
    destroy = false
  }
}