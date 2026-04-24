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
  to = module.common_cdn.azurerm_cdn_frontdoor_route.assets_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-assets-gsh3hqbybxhphrf3.z01.azurefd.net/routes/iopcdnendpointassets"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_route.developer_io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-developerportal-c6e4fmgph6c5c8bs.z01.azurefd.net/routes/iopcdnendpointdeveloperportal"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_route.io_italia_it
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/afdEndpoints/io-p-cdnendpoint-iowebsite-c9fhh2hnehg3dmes.z01.azurefd.net/routes/iopcdnendpointiowebsite"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_route.static_web_io_italia_it
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
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_global
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Global"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_enforce_https
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/EnforceHTTPS"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_fix_dots
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/FixDots"
}

import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_fix_dots2
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/FixDots2"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_redirect_firma
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/RedirectFirma"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_faq
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Faq"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_documenti_su_io_faq
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/DocumentiSuIoFaq"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_carta_giovani_faq
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CartaGiovaniFaq"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_funzionalita_dismessa
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/FunzionalitaDismess"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_giornalisti
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Giornalisti"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_pubbliche_amministrazioni
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/PubblicheAmministrazioni"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_enti_nazionali
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/EntiNazionali"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cittadini
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Cittadini"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cgn_guida_beneficiari
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CGNGuidaBeneficiari"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cgn_informativa_beneficiari
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CGNInformativaBeneficiari"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_cgn_informative_operatori
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/CGNInformativeOperatori"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_note_legali
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/NoteLegali"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_privacy_policy
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/PrivacyPolicy"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_informativa_newsletter
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/InformativaNewsletter"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_same_path
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/SamePath"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_homepage
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/Homepage"
}
import {
  to = module.common_cdn.azurerm_cdn_frontdoor_rule.io_italia_it_io_web
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Cdn/profiles/io-p-cdn-common/ruleSets/Migratediopcdnendpointiowebsite/rules/IoWeb"
}