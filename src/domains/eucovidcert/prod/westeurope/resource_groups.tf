// TODO: Before remove the RG delete all resources inside it not mapped in Terraform
module "resource_groups" {
  source = "../../_modules/resource_groups"

  location = local.location
  project  = local.project

  tags = local.tags
}
