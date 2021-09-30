env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS300 - PRODOTTI E SERVIZI"
}

external_domain = "pagopa.it"
dns_zone_prefix = "platform"

lock_enable              = true
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

common_rg = "io-p-rg-common"

# Network
vnet_name = "io-p-vnet-common"