# User Assigned Identities
moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_user_assigned_identity.identity
  to   = module.federated_identities.azurerm_user_assigned_identity.cd[0]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_user_assigned_identity.identity
  to   = module.federated_identities.azurerm_user_assigned_identity.ci[0]
}

# Federated Identity Credentials
moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_federated_identity_credential.identity_credentials["io-infra.environment.prod-cd"]
  to   = module.federated_identities.azurerm_federated_identity_credential.cd_github[0]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_federated_identity_credential.identity_credentials["io-infra.environment.prod-ci"]
  to   = module.federated_identities.azurerm_federated_identity_credential.ci_github[0]
}

# CD Resource Group Role Assignments
moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_rg_role_assignment[0]
  to   = module.federated_identities.azurerm_role_assignment.cd_rg[0]
}

# CD Subscription Role Assignments
moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Container Apps Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Container Apps Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Key Vault Certificates Officer"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Key Vault Certificates Officer"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Key Vault Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Key Vault Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Key Vault Secrets Officer"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Key Vault Secrets Officer"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Role Based Access Control Administrator"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Role Based Access Control Administrator"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Account Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Storage Account Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Blob Data Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Storage Blob Data Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage File Data SMB Share Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Storage File Data SMB Share Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Queue Data Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Storage Queue Data Contributor"]
}

moved {
  from = module.federated_identities.module.federated_cd_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Table Data Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.cd_subscription["Storage Table Data Contributor"]
}

# CI Resource Group Role Assignments
moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_rg_role_assignment[0]
  to   = module.federated_identities.azurerm_role_assignment.ci_rg[0]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_rg_role_assignment[1]
  to   = module.federated_identities.azurerm_role_assignment.ci_rg[1]
}

# CI Subscription Role Assignments
moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["API Management Service Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["API Management Service Contributor"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Container Apps Operator"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Container Apps Operator"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["DocumentDB Account Contributor"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["DocumentDB Account Contributor"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Key Vault Certificate User"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Key Vault Certificate User"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Key Vault Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Key Vault Reader"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Key Vault Secrets User"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Key Vault Secrets User"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["PagoPA IaC Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["PagoPA IaC Reader"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Reader"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Reader and Data Access"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Reader and Data Access"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Blob Data Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Storage Blob Data Reader"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage File Data SMB Share Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Storage File Data SMB Share Reader"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Queue Data Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Storage Queue Data Reader"]
}

moved {
  from = module.federated_identities.module.federated_ci_identity[0].azurerm_role_assignment.identity_subscription_role_assignment["Storage Table Data Reader"]
  to   = module.federated_identities.azurerm_role_assignment.ci_subscription["Storage Table Data Reader"]
}