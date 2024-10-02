module "test_users" {
  source = "../"
}

output "test_users" {
  value = module.test_users.users
}