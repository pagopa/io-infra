module "test_users" {
  source = "../../_modules/test_users"
}

output "test_users" {
  value = module.test_users.users
}