locals {
  firmaconio_project = format("%s-sign", local.project)
  firmaconio = {
    resource_group_names = {
      backend = format("%s-backend-rg", local.firmaconio_project)
    }
  }
}
