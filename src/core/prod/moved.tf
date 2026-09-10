moved {
  from = module.storage_accounts_itn.azurerm_storage_account.terraform
  to   = module.storage_accounts_itn.azurerm_storage_account.terraform_state_itn[0]
}


moved {
  from = module.storage_accounts_itn.module.iam_adgroup_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|owner"]
  to   = module.storage_accounts_itn.module.iam_adgroup_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|owner"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_auth_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_auth_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_auth_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_auth_devs[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_bonus_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_bonus_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_bonus_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_bonus_devs[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_com_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_com_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_com_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_com_devs[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_platform_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_platform_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_platform_externals.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_platform_externals[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_svc_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_svc_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_svc_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_svc_devs[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_wallet_admins.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_wallet_admins[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_adgroup_wallet_devs.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_adgroup_wallet_devs[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}

moved {
  from = module.storage_accounts_itn.module.iam_messages_sp.module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
  to   = module.storage_accounts_itn.module.iam_messages_sp[0].module.storage_account.azurerm_role_assignment.blob["iopitntfst001|*|writer"]
}