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
    ]
    response_header_configurations = []
  }
  
  nonstandard = {
    weu = {
      evh-rg   = "${var.project}-evt-rg"
      evh-snet = "${var.project}-eventhub-snet"
      evh-ns   = "${var.project}-evh-ns"
    }
  }
}
