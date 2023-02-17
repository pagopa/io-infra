locals {
  project  = "${var.prefix}-${var.env_short}"
  app_name = "github-${var.github.org}-${var.github.repository}-${var.env}"
}
