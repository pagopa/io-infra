locals {
  ag_formatted_project = replace(var.project, "-", "")

  nonstandard = {
    weu = {

      log  = "${var.project}-law-common"
      appi = "${var.project}-ai-common"

      ag_error = "${local.ag_formatted_project}error"

      ag_quarantine_error       = "${local.ag_formatted_project}quarantineerror"
      ag_quarantine_error_short = "${local.ag_formatted_project}qerr"

      ag_ts_error       = "${local.ag_formatted_project}trialsystemerror"
      ag_ts_error_short = "${replace(var.project, "-", "")}tserr"
    }
  }
}
