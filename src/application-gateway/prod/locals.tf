locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  external_domain              = "pagopa.it"
  dns_zone_io                  = "io"
  dns_zone_io_selfcare         = "io.selfcare"
  dns_zone_firmaconio_selfcare = "firmaconio.selfcare"

  firmaconio_project = format("%s-sign", local.project)
  firmaconio = {
    resource_group_names = {
      backend = format("%s-backend-rg", local.firmaconio_project)
    }
  }

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/application-gateway/prod"
  }

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
}
