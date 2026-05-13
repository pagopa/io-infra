# Use this file to import the wanted resources inside the state file, 
# remember to cleanup the import code blocks with a separate PR once the import has been completed successfully.
# Here is the documentation which explains how to use the import code block: https://developer.hashicorp.com/terraform/language/block/import


import {
  to = module.assets_locales.azurerm_cdn_frontdoor_custom_domain.logos_custom_domain
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/customDomains/io-p-itn-logos-assets-domain"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_endpoint.logos_endpoint
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/afdEndpoints/io-p-itn-assets-fde-02"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_origin.logos_origin
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/originGroups/io-p-itn-assets-fdog-02/origins/iopstcdnassets"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_origin_group.logos_origin_group
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/originGroups/io-p-itn-assets-fdog-02"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_route.logos_route
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/afdEndpoints/io-p-itn-assets-fde-02/routes/io-p-itn-assets-cdnr-02"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.caching_rules["assistance_tools_zendesk"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/assistancetoolszendeskCache"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.caching_rules["bonus"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/bonusCache"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.caching_rules["servicesdata"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/servicesdataCache"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.caching_rules["status"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/statusCache"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.global_cache
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/globalCache"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.logos_global_cache
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/logosruleset/rules/globalCache"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.redirect_rules["organization_logos"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/organizationlogosRewrite"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.redirect_rules["service_logos"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/serviceslogosRewrite"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.redirect_rules["services_webview"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/serviceswebviewRewrite"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule.sign_origin
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset/rules/signOrigin"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_rule_set.logos_ruleset
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/logosruleset"
}

import {
  to = module.assets_locales.azurerm_dns_cname_record.logos_custom_domain_dns_record
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/CNAME/logos.assets"
}

import {
  to = module.assets_locales.azurerm_dns_txt_record.logos_custom_domain_validation_txt_record
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/TXT/_dnsauth.logos.assets"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain.this["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/customDomains/assets-cdn-io-italia-it"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain.this["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/customDomains/assets-cdn-io-pagopa-it"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain.this["assets.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/customDomains/assets-io-pagopa-it"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain_association.this["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/associations/assets-cdn-io-italia-it"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain_association.this["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/associations/assets-cdn-io-pagopa-it"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_custom_domain_association.this["assets.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/associations/assets-io-pagopa-it"
}

import {
  to = module.assets_locales.azurerm_cdn_frontdoor_custom_domain_association.logos_custom_domain_association
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/associations/logos-assets-io-pagopa-it"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_endpoint.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/afdEndpoints/io-p-itn-assets-fde-01"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_origin.this["storage-account"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/originGroups/io-p-itn-assets-fdog-01/origins/io-p-itn-assets-storage-account-fdo-01"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_origin_group.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/originGroups/io-p-itn-assets-fdog-01"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_profile.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_route.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/afdEndpoints/io-p-itn-assets-fde-01/routes/io-p-itn-assets-cdnr-01"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_cdn_frontdoor_rule_set.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01/ruleSets/ruleset"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_dns_cname_record.this["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/CNAME/assets.cdn"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_dns_cname_record.this["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/CNAME/assets.cdn"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_dns_cname_record.this["assets.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/CNAME/assets"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_dns_txt_record.validation["assets.cdn.io.italia.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/_dnsauth.assets.cdn"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_dns_txt_record.validation["assets.cdn.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/TXT/_dnsauth.assets.cdn"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_dns_txt_record.validation["assets.io.pagopa.it"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/TXT/_dnsauth.assets"
}

import {
  to = module.assets_locales.module.azure_cdn.azurerm_monitor_diagnostic_setting.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-assets-cdn-rg-01/providers/Microsoft.Cdn/profiles/io-p-itn-assets-afd-01|io-p-itn-assets-cdnp-01"
}

import {
  to = module.assets_locales.module.cdn_storage.azurerm_monitor_metric_alert.storage_account_health_check[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Insights/metricAlerts/[iopitnassetsst01]"
}

import {
  to = module.assets_locales.module.cdn_storage.azurerm_security_center_storage_defender.this[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnassetsst01"
}

import {
  to = module.assets_locales.module.cdn_storage.azurerm_storage_account.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnassetsst01"
}

import {
  to = module.assets_locales.module.storage_account_permissions["svc_devs"].module.storage_account.azurerm_role_assignment.blob["iopitnassetsst01|*|writer|PagoPA Storage Blob Tags Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnassetsst01/providers/Microsoft.Authorization/roleAssignments/a18207a1-2e69-9930-06f8-49bc4919474a"
}

import {
  to = module.assets_locales.module.storage_account_permissions["svc_devs"].module.storage_account.azurerm_role_assignment.blob["iopitnassetsst01|*|writer|Storage Blob Data Contributor"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-itn-common-rg-01/providers/Microsoft.Storage/storageAccounts/iopitnassetsst01/providers/Microsoft.Authorization/roleAssignments/33fe3b7f-efd8-8b3b-d1d9-6a19336181c1"
}
