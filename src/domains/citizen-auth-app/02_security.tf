data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}


resource "azurerm_key_vault_certificate" "lollipop_certificate_v1" {
  name         = "lollipop-certificate-v1"
  key_vault_id = data.azurerm_key_vault.kv.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 90
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = local.lollipop_jwt_issuer
      validity_in_months = 24
    }
  }
}


data "azurerm_key_vault_certificate_data" "lollipop_certificate_v1" {
  name         = resource.azurerm_key_vault_certificate.lollipop_certificate_v1.name
  key_vault_id = data.azurerm_key_vault.kv.id
}
