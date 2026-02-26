### Common resources

locals {
  name = var.name

  app_command_line = "pm2 start dist/src/server.js -i max --no-daemon"

  webtest = {
    path        = "/info",
    http_status = 200,
  }

  service_ids = {
    pn               = "01G40DWQGKY5GRWSNM4303VNRP"
    io_sign          = "01GQQZ9HF5GAPRVKJM1VDAVFHM"
    io_receipt_test  = "01H4ZJ62C1CPGJ0PX8Q1BP7FAB"
    io_receipt       = "01HD63674XJ1R6XCNHH24PCRR2"
    third_party_mock = "01GQQDPM127KFGG6T3660D5TXD"
    pn_remote_config = "01HMVMHCZZ8D0VTFWMRHBM5D6F"
  }

  endpoints = {
    pn              = "https://api-io.notifichedigitali.it"
    pn_test         = "https://api-io.uat.notifichedigitali.it"
    io_receipt_test = "https://api.uat.platform.pagopa.it/receipts/service/v1"
    io_receipt      = "https://api.platform.pagopa.it/receipts/service/v1"
  }

  function_app_count = length(var.backend_hostnames.app)

  nonstandard = {
    weu = {
      asp  = "${var.project}-plan-appappbackend${var.name}"
      app  = "${var.project}-app-appbackend${var.name}"
      snet = "appbackend${var.name}"
    }
  }

}
