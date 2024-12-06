
output "scaling_gate" {
  description = <<EOF
  WHAT: Name and configuration for gates on release, to be changed at each release with the most up-to-date values
  HOW: These values ​​will be used for scaling the different resources (function app, app services, etc.)
  EOF
  value = {
    name     = "wallet_ga2"
    timezone = "W. Europe Standard Time"
    start    = "2024-12-06T12:00:00Z"
    end      = "2024-12-06T20:00:00Z"
  }
}
