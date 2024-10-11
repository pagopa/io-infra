module "test_users" {
  source = "../../_modules/test_users"
}

locals {

  test_users = module.test_users.users.all

  test_users_light = module.test_users.users.light

  test_users_internal_flat = module.test_users.users.internal_flat

  test_users_internal_load_flat = module.test_users.users.internal_load_flat

  test_users_store_review_flat = module.test_users.users.store_review_flat

  test_users_eu_covid_cert_flat = module.test_users.users.eu_covid_cert_flat

  test_users_unique_email_test = module.test_users.users.unique_email_test

}