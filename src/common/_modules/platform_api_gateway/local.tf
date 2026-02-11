locals {
  proxy_hostname_internal = "proxy.internal.io.pagopa.it"
  apim_appname            = "platform-api-gateway"


  apim_adgroup_rbac = [
    {
      principal_id = var.azure_adgroup_platform_admins_object_id
      description  = "Platform team admin group"
      role         = "owner"
    },
    {
      principal_id = var.azure_adgroup_auth_admins_object_id
      description  = "Auth & Identity team admin group"
      role         = "owner"
    },
    {
      principal_id = var.azure_user_assigned_identity_auth_infra_cd
      description  = "Auth & Identity team infra CD identity"
      role         = "owner"
    },
    {
      principal_id = var.azure_adgroup_bonus_admins_object_id
      description  = "Bonus team admin group"
      role         = "owner"
    },
    {
      principal_id = var.azure_user_assigned_identity_bonus_infra_cd
      description  = "Bonus team infra CD identity"
      role         = "owner"
    },
    {
      principal_id = var.azure_adgroup_com_admins_object_id
      description  = "Communication team admin group"
      role         = "owner"
    },
    {
      principal_id = var.azure_user_assigned_identity_com_infra_cd
      description  = "Communication team infra CD identity"
      role         = "owner"
    },
    {
      principal_id = var.azure_user_assigned_identity_fims_infra_cd
      description  = "FIMS infra CD identity"
      role         = "owner"
    }
  ]
}
