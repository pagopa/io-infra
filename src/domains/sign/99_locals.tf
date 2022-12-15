locals {
  project = format("%s-%s-%s", var.prefix, var.env_short, var.domain)
  product = format("%s-%s", var.prefix, var.env_short)
}
