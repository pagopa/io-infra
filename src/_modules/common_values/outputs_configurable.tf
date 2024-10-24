
output "scaling_gate" {
  description = <<EOF
  WHAT: Name and configuration for gates on release, to be changed at each release with the most up-to-date values
  HOW: These values ​​will be used for scaling the different resources (function app, app services, etc.)
  EOF
  value = {
    name     = "wallet_gate1"
    timezone = "W. Europe Standard Time"
    start    = "2024-10-23T08:00:00.000Z"
    end      = "2024-10-23T22:00:00.000Z"
  }
}