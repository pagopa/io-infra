##############
## Products ##
##############

module "apim_itn_io_backend_product" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.27.0"

  product_id   = "io-backend"
  display_name = "IO BACKEND"
  description  = "Product for IO backend"

  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io_backend/_base_policy.xml")
}

locals {
  apim_itn_io_backend_api = {
    # params for all api versions
    display_name          = "IO BACKEND API"
    description           = "IO backend APIs"
    path                  = "api/io-backend"
    subscription_required = false
    service_url           = null
  }
}

## BPD
resource "azurerm_api_management_api_version_set" "io_backend_bpd_api_itn" {
  name                = format("%s-io-backend-bpd-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - bpd"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_bpd_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-bpd-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_bpd_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - bpd"
  display_name = "${local.apim_itn_io_backend_api.display_name} - bpd"
  path         = "bpd/api"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/bpd/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/bpd/v1/_base_policy.xml")
}
##

## MYPORTAL
resource "azurerm_api_management_api_version_set" "io_backend_myportal_api_itn" {
  name                = format("%s-io-backend-myportal-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - myportal"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_myportal_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-myportal-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_myportal_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - myportal"
  display_name = "${local.apim_itn_io_backend_api.display_name} - myportal"
  path         = "myportal/api"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/myportal/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/myportal/v1/_base_policy.xml")
}
##

## PAGOPA
resource "azurerm_api_management_api_version_set" "io_backend_pagopa_api_itn" {
  name                = format("%s-io-backend-pagopa-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - pagopa"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_pagopa_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-pagopa-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_pagopa_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - pagopa"
  display_name = "${local.apim_itn_io_backend_api.display_name} - pagopa"
  path         = "pagopa/api"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/pagopa/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/pagopa/v1/_base_policy.xml")
}
##

## APP
resource "azurerm_api_management_api_version_set" "io_backend_app_api_itn" {
  name                = format("%s-io-backend-app-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - app"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_app_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-app-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_app_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - app"
  display_name = "${local.apim_itn_io_backend_api.display_name} - app"
  path         = "${local.apim_itn_io_backend_api.path}/app"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/app/v1/_swagger_v2.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/app/v1/_base_policy.xml")
  api_operation_policies = [
    {
      operation_id = "getUserMessages"
      xml_content  = file("./api/io_backend/app/v1/operations/getUserMessages.xml")
    }
  ]
}
##

## AUTH
resource "azurerm_api_management_api_version_set" "io_backend_auth_api_itn" {
  name                = format("%s-io-backend-auth-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - auth"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_auth_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-auth-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_auth_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - auth"
  display_name = "${local.apim_itn_io_backend_api.display_name} - auth"
  path         = "${local.apim_itn_io_backend_api.path}/auth"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/auth/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/auth/v1/_base_policy.xml")
}

## CGN
resource "azurerm_api_management_api_version_set" "io_backend_cgn_api_itn" {
  name                = format("%s-io-backend-cgn-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - cgn"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_cgn_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-cgn-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_cgn_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - cgn"
  display_name = "${local.apim_itn_io_backend_api.display_name} - cgn"
  path         = "${local.apim_itn_io_backend_api.path}/cgn"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/cgn/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/cgn/v1/_base_policy.xml")
}
##

## EUCOVIDCERT
resource "azurerm_api_management_api_version_set" "io_backend_eucovidcert_api_itn" {
  name                = format("%s-io-backend-eucovidcert-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - eucovidcert"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_eucovidcert_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-eucovidcert-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_eucovidcert_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - eucovidcert"
  display_name = "${local.apim_itn_io_backend_api.display_name} - eucovidcert"
  path         = "${local.apim_itn_io_backend_api.path}/eucovidcert"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/eucovidcert/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/eucovidcert/v1/_base_policy.xml")
}
##

## MITVOUCHER
resource "azurerm_api_management_api_version_set" "io_backend_mitvoucher_api_itn" {
  name                = format("%s-io-backend-mitvoucher-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - mitvoucher"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_mitvoucher_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-mitvoucher-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_mitvoucher_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - mitvoucher"
  display_name = "${local.apim_itn_io_backend_api.display_name} - mitvoucher"
  path         = "${local.apim_itn_io_backend_api.path}/mitvoucher"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/mitvoucher/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/mitvoucher/v1/_base_policy.xml")
}
##

## NOTIFICATIONS
resource "azurerm_api_management_api_version_set" "io_backend_notifications_api_itn" {
  name                = format("%s-io-backend-notifications-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - notifications"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_notifications_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-notifications-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_notifications_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - notifications"
  display_name = "${local.apim_itn_io_backend_api.display_name} - notifications"
  path         = "${local.apim_itn_io_backend_api.path}/notifications"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/notifications/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/notifications/v1/_base_policy.xml")
}
##

## PUBLIC
resource "azurerm_api_management_api_version_set" "io_backend_public_api_itn" {
  name                = format("%s-io-backend-public-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - public"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_public_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-public-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_public_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - public"
  display_name = "${local.apim_itn_io_backend_api.display_name} - public"
  path         = "${local.apim_itn_io_backend_api.path}/public"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/public/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/public/v1/_base_policy.xml")
}
##

## SESSION
resource "azurerm_api_management_api_version_set" "io_backend_session_api_itn" {
  name                = format("%s-io-backend-session-api", local.env_short)
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  api_management_name = data.azurerm_api_management.apim_itn.name
  display_name        = "${local.apim_itn_io_backend_api.display_name} - session"
  versioning_scheme   = "Segment"
}

module "apim_itn_io_backend_session_api_v1" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                  = format("%s-io-backend-session-api", local.env_short)
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  product_ids           = [module.apim_itn_io_backend_product.product_id]
  subscription_required = local.apim_itn_io_backend_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.io_backend_session_api_itn.id
  api_version           = "v1"
  service_url           = local.apim_itn_io_backend_api.service_url

  description  = "${local.apim_itn_io_backend_api.description} - session"
  display_name = "${local.apim_itn_io_backend_api.display_name} - session"
  path         = "${local.apim_itn_io_backend_api.path}/session"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/io_backend/session/v1/_swagger.json.tpl", {
    host = local.apim_hostname_api_app_internal # api-app.internal.io.pagopa.it
  })

  xml_content = file("./api/io_backend/session/v1/_base_policy.xml")
}
##
