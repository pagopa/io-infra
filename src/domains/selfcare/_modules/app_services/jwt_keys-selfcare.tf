#tfsec:ignore:azure-keyvault-ensure-secret-expiry:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "selfcare_jwt" {
  source = "github.com/pagopa/terraform-azurerm-v3//jwt_keys?ref=v7.64.0"

  jwt_name         = "selfcare-jwt"
  key_vault_id     = data.azurerm_key_vault.key_vault_common.id
  cert_common_name = "IO selfcare"
  cert_password    = ""

  tags = var.tags
}
