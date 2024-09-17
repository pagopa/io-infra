locals {
  nonstandard = {
    weu = {
      snet_name = "apimv2api"
      nsg_name  = "${var.project}-apim-v2-nsg"
      pip_name  = "${var.project}-apim-v2-public-ip"
      apim_name = "${var.project}-apim-v2-api"
    }
  }

  apim_hostname_api_internal     = "api-internal.io.italia.it"
  apim_hostname_api_app_internal = "api-app.internal.io.pagopa.it"
}
