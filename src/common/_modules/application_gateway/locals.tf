locals {
  io_backend_ip_headers_rule = {
    name          = "http-headers-api-app"
    rule_sequence = 100
    conditions    = []
    url           = null
    request_header_configurations = [
      {
        header_name  = "X-Forwarded-For"
        header_value = "{var_client_ip}"
      },
      {
        header_name  = "X-Client-Ip"
        header_value = "{var_client_ip}"
      },
      {
        header_name  = "X-User"
        header_value = ""
      },
    ]
    response_header_configurations = []
  }

  nonstandard = {
    weu = {
      waf_api_app = "${var.project}-waf-appgateway-api-app-policy"
      agw         = "${var.project}-appgateway"
      snet        = "${var.project}-appgateway-snet"
      pip         = "${var.project}-appgateway-pip"
      id          = "${var.project}-appgateway-identity"
    }
  }
}
