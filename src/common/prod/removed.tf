# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.private_endpoints.azurerm_private_endpoint.this

  lifecycle {
    destroy = false
  }
}
