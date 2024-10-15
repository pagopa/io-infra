module "naming_convention" {
  source = "github.com/pagopa/dx//infra/modules/azure_naming_convention/?ref=main"

  environment = {
    prefix          = var.environment.prefix
    env_short       = var.environment.env_short
    location        = var.environment.location
    domain          = var.environment.domain
    app_name        = var.environment.app_name
    instance_number = var.environment.instance_number
  }
}
