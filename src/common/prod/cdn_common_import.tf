# Profile

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_profile.common_cdn
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common"
}

# Custom domains

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/customDomains/assets.io.italia.it"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/customDomains/developer.io.italia.it"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/customDomains/io.italia.it"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/customDomains/static-web.io.italia.it"
}

# DNS

import {
  to = module.common_cdn.azurerm_dns_txt_record.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/_dnsauth.assets"
}

import {
  to = module.common_cdn.azurerm_dns_a_record.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/@"
}

import {
  to = module.common_cdn.azurerm_dns_txt_record.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/TXT/_dnsauth.static-web"
}

# Endpoints

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-assets-gsh3hqbybxhphrf3.z01.azurefd.net"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-developerportal-c6e4fmgph6c5c8bs.z01.azurefd.net"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-iowebsite-c9fhh2hnehg3dmes.z01.azurefd.net"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-websiteassets-cee2faeydmc4f5am.z01.azurefd.net"
}

# Origin groups

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin_group.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-assets-Default"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin_group.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-developerportal-Default"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin_group.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-iowebsite-Default"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin_group.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-websiteassets-Default"
}

# Origins

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-assets-Default/origins/primary"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-developerportal-Default/origins/primary"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-iowebsite-Default/origins/primary"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_origin.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/originGroups/io-p-cdnendpoint-websiteassets-Default/origins/primary"
}

# Routes

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-assets-gsh3hqbybxhphrf3.z01.azurefd.net/routes/iopcdnendpointassets"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-developerportal-c6e4fmgph6c5c8bs.z01.azurefd.net/routes/iopcdnendpointdeveloperportal"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-iowebsite-c9fhh2hnehg3dmes.z01.azurefd.net/routes/iopcdnendpointiowebsite"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_endpoint.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-websiteassets-cee2faeydmc4f5am.z01.azurefd.net/routes/iopcdnendpointwebsiteassets"
}

# Custom domains associations

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain_association.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/associations/assets.io.italia.it"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain_association.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/associations/developer.io.italia.it"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain_association.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/associations/io.italia.it"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_custom_domain_association.static_web_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/associations/static-web.io.italia.it"
}

# Rulesets

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule_set.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointassets"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule_set.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointdeveloperportal"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule_set.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite"
}

### Rules

# Assets

locals {
  common_cdn_assets_rules_ids = {
    assets_io_italia_it_global_cache        = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointassets/rules/Global"
    assets_io_italia_it_services_data_cache = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointassets/rules/servicesdatacache"
    assets_io_italia_it_bonus_cache         = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointassets/rules/bonuscache"
    assets_io_italia_it_status_cache        = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointassets/rules/statuscache"
  }
  common_cdn_assets_rules_resources = {
    assets_io_italia_it_global_cache        = module.common_cdn.azurerm_cdn_frontdoor_rule.assets_io_italia_it_global_cache
    assets_io_italia_it_services_data_cache = module.common_cdn.azurerm_cdn_frontdoor_rule.assets_io_italia_it_services_data_cache
    assets_io_italia_it_bonus_cache         = module.common_cdn.azurerm_cdn_frontdoor_rule.assets_io_italia_it_bonus_cache
    assets_io_italia_it_status_cache        = module.common_cdn.azurerm_cdn_frontdoor_rule.assets_io_italia_it_status_cache
  }
}

import {
  for_each = local.common_cdn_assets_rules_ids
  to       = local.common_cdn_assets_rules_resources[each.key]
  id       = each.value
}

# Developer Portal

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.developer_io_italia_it_enforce_https
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointdeveloperportal/rules/EngorceHTTPS"
}

# IO Italia

locals {
  io_italia_it_rules_ids = {
    io_italia_it_global                      = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Global"
    io_italia_it_enforce_https               = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/EnforceHTTPS"
    io_italia_it_fix_dots                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/FixDots"
    io_italia_it_fix_dots2                   = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/FixDots2"
    io_italia_it_redirect_firma              = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/RedirectFirma"
    io_italia_it_faq                         = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Faq"
    io_italia_it_documenti_su_io_faq         = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/DocumentiSuIoFaq"
    io_italia_it_carta_giovani_faq           = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CartaGiovaniFaq"
    io_italia_it_funzionalita_dismess        = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/FunzionalitaDismess"
    io_italia_it_giornalisti                 = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Giornalisti"
    io_italia_it_pubbliche_amministrazioni   = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/PubblicheAmministrazioni"
    io_italia_it_enti_nazionali              = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/EntiNazionali"
    io_italia_it_cittadini                   = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Cittadini"
    io_italia_it_cgn_guida_beneficiari       = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CGNGuidaBeneficiari"
    io_italia_it_cgn_informativa_beneficiari = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CGNInformativaBeneficiari"
    io_italia_it_cgn_informative_operatori   = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CGNInformativeOperatori"
    io_italia_it_note_legali                 = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/NoteLegali"
    io_italia_it_privacy_policy              = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/PrivacyPolicy"
    io_italia_it_informativa_newsletter      = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/InformativaNewsletter"
    io_italia_it_same_path                   = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/SamePath"
    io_italia_it_homepage                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Homepage"
    io_italia_it_io_web                      = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/IoWeb"
  }

  io_italia_it_rules_resources = {
    io_italia_it_global                      = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_global
    io_italia_it_enforce_https               = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_enforce_https
    io_italia_it_fix_dots                    = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_fix_dots
    io_italia_it_fix_dots2                   = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_fix_dots2
    io_italia_it_redirect_firma              = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_redirect_firma
    io_italia_it_faq                         = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_faq
    io_italia_it_documenti_su_io_faq         = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_documenti_su_io_faq
    io_italia_it_carta_giovani_faq           = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_carta_giovani_faq
    io_italia_it_funzionalita_dismess        = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_funzionalita_dismess
    io_italia_it_giornalisti                 = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_giornalisti
    io_italia_it_pubbliche_amministrazioni   = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_pubbliche_amministrazioni
    io_italia_it_enti_nazionali              = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_enti_nazionali
    io_italia_it_cittadini                   = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cittadini
    io_italia_it_cgn_guida_beneficiari       = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cgn_guida_beneficiari
    io_italia_it_cgn_informativa_beneficiari = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cgn_informativa_beneficiari
    io_italia_it_cgn_informative_operatori   = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cgn_informative_operatori
    io_italia_it_note_legali                 = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_note_legali
    io_italia_it_privacy_policy              = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_privacy_policy
    io_italia_it_informativa_newsletter      = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_informativa_newsletter
    io_italia_it_same_path                   = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_same_path
    io_italia_it_homepage                    = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_homepage
    io_italia_it_io_web                      = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_io_web
  }
}

import {
  for_each = local.io_italia_it_rules_ids
  to       = local.io_italia_it_rules_resources[each.key]
  id       = each.value
}
