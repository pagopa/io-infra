locals {
  ag_formatted_project = replace(var.project, "-", "")

  nonstandard = {
    weu = {

      log  = "${var.project}-law-common"
      appi = "${var.project}-ai-common"

      ag_error = "${local.ag_formatted_project}error"

      ag_quarantine_error       = "${local.ag_formatted_project}quarantineerror"
      ag_quarantine_error_short = "${local.ag_formatted_project}qerr"

      email_pagopa = "EmailPagoPA"
      slack_pagopa = "SlackPagoPA"
    }

    itn = {

      log  = "${var.project}-common-law-01"
      appi = "${var.project}-common-appi-01"

      ag_error = "${local.ag_formatted_project}error"

      ag_quarantine_error       = "${local.ag_formatted_project}quarantineerror"
      ag_quarantine_error_short = "${local.ag_formatted_project}qerr"

      email_pagopa = "EmailPagoPA"
      slack_pagopa = "SlackPagoPA"
    }
  }

  appi_reserved_ips = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]
}
