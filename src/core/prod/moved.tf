
# Storage Account - AD Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|owner"]

  to = module.storage_accounts_itn.module.iam_adgroup_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|owner|Storage Blob Data Owner"]
}

# Storage Account - Auth Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_auth_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_auth_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Auth Devs
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_auth_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_auth_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Bonus Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_bonus_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_bonus_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Bonus Devs
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_bonus_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_bonus_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - COM Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_com_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_com_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - COM Devs
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_com_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_com_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Platform Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_platform_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_platform_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Platform Externals
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_platform_externals.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_platform_externals.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - SVC Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_svc_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_svc_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - SVC Devs
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_svc_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_svc_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Wallet Admins
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_wallet_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_wallet_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Wallet Devs
moved {
  from = module.storage_accounts_itn.module.iam_adgroup_wallet_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_adgroup_wallet_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}

# Storage Account - Messages Service Principal
moved {
  from = module.storage_accounts_itn.module.iam_messages_sp.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]

  to = module.storage_accounts_itn.module.iam_messages_sp.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer|Storage Blob Data Contributor"]
}
