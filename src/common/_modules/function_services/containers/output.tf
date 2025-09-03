output "container_subscription_cidrs" {
  value = {
    id   = module.db_subscription_cidrs_container.id
    name = module.db_subscription_cidrs_container.name
  }
}
