locals {
  nonstandard = {
    itn = {
      autoscale_name = "${var.project}-apim-01-autoscale"
    }
  }

  apim_hostname_api_internal     = "api-internal.io.italia.it"
  apim_hostname_api_app_internal = "api-app.internal.io.pagopa.it"
}
