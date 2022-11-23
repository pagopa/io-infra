prefix    = "io"
env_short = "p"
domain    = "sign"
location  = "westeurope"

io_sign_issuer_func = {
  version  = "io-func-sign-issuer-85f3331e"
  sku_tier = "Basic"
  sku_size = "B1"
}

io_sign_user_func = {
  version  = "io-func-sign-user-85f3331"
  sku_tier = "Basic"
  sku_size = "B1"
}

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/src/sign"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}
