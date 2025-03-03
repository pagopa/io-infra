locals {
  project_dev = "io-d"
  project     = "io-p"

  identity_resource_group_name_dev = "${local.project_dev}-identity-rg"
  identity_resource_group_name     = "${local.project}-identity-rg"

  repo_secrets = {
    "ARM_TENANT_ID" = data.azurerm_client_config.current.tenant_id,
  }

  prod_ci = {
    secrets = {
      "ARM_CLIENT_ID"       = data.azurerm_user_assigned_identity.identity_prod_ci.client_id,
      "ARM_SUBSCRIPTION_ID" = data.azurerm_subscription.current.subscription_id
    }
  }

  dev_ci = {
    secrets = {
      "ARM_CLIENT_ID"       = data.azurerm_user_assigned_identity.identity_dev_ci.client_id,
      "ARM_SUBSCRIPTION_ID" = data.azurerm_subscription.dev_io.subscription_id
    }
  }

  prod_cd = {
    secrets = {
      "ARM_CLIENT_ID"       = data.azurerm_user_assigned_identity.identity_prod_cd.client_id,
      "ARM_SUBSCRIPTION_ID" = data.azurerm_subscription.current.subscription_id
    }
    reviewers_teams = ["io-backend-contributors", "io-backend-admin", "engineering-team-cloud-eng"]
  }

  dev_cd = {
    secrets = {
      "ARM_CLIENT_ID"       = data.azurerm_user_assigned_identity.identity_dev_cd.client_id,
      "ARM_SUBSCRIPTION_ID" = data.azurerm_subscription.dev_io.subscription_id
    }
    reviewers_teams = ["io-backend-contributors", "io-backend-admin", "engineering-team-cloud-eng"]
  }

  apim_prod = {
    secrets = {
      "ARM_CLIENT_ID"       = data.azurerm_user_assigned_identity.identity_prod_apim.client_id,
      "ARM_SUBSCRIPTION_ID" = data.azurerm_subscription.current.subscription_id
    }
    reviewers_teams = ["engineering-team-cloud-eng"]
  }
}
