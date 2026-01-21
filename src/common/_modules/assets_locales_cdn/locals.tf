locals {
  nonstandard = {
    weu = {
      cdne = "${var.project}-assets-cdn-endpoint"
    }
    itn = {
      cdne = "${var.project}-assets-cdn-endpoint"
    }
  }
  routes = {
    abi_logos = {
      name        = "abi-logos-route"
      pattern     = "/logos/abi/*"
      origin_path = "/logos/abi"
    }
    app_logos = {
      name        = "app-logos-route"
      pattern     = "/logos/apps/*"
      origin_path = "/logos/apps"
    }
    assistance_tools = {
      name        = "assistance-tools-route"
      pattern     = "/assistanceTools/*"
      origin_path = "/assistanceTools"
    }
    bonus = {
      name        = "bonus-route"
      pattern     = "/bonus/*"
      origin_path = "/bonus"
    }
    contextualhelp = {
      name        = "contextualhelp-route"
      pattern     = "/contextualhelp/*"
      origin_path = "/contextualhelp"
    }
    email_assets = {
      name        = "email-assets-route"
      pattern     = "/email-assets/*"
      origin_path = "/email-assets"
    }
    eucovidcert_logos = {
      name        = "eucovidcert-logos-route"
      pattern     = "/logos/eucovidcert/*"
      origin_path = "/logos/eucovidcert"
    }
    html = {
      name        = "html-route"
      pattern     = "/html/*"
      origin_path = "/html"
    }
    locales = {
      name        = "locales-route"
      pattern     = "/locales/*"
      origin_path = "/locales"
    }
    municipalities = {
      name        = "municipalities-route"
      pattern     = "/municipalities/*"
      origin_path = "/municipalities"
    }
    organization_logos = {
      name        = "organization-logos-route"
      pattern     = "/logos/organizations/*"
      origin_path = "/services"
    }
    privative_logos = {
      name        = "privative-logos-route"
      pattern     = "/logos/privative/*"
      origin_path = "/logos/privative"
    }
    service_logos = {
      name        = "service-logos-route"
      pattern     = "/logos/services/*"
      origin_path = "/services"
    }
    services_webview = {
      name        = "services-webview-route"
      pattern     = "/services-webview/*"
      origin_path = "/services/services-webview"
    }
    sign = {
      name        = "sign-route"
      pattern     = "/sign/*"
      origin_path = "/sign"
    }
    spid_idps = {
      name        = "spid-idps-route"
      pattern     = "/spid/idps/*"
      origin_path = "/spid/idps"
    }
  }
}
