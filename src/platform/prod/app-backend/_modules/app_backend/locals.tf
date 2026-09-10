### Common resources

locals {

  app_command_line = "pm2 start dist/src/server.js -i max --no-daemon"

  webtest = {
    path        = "/info",
    http_status = 200,
  }

  service_ids = {
    pn               = "01G40DWQGKY5GRWSNM4303VNRP"
    pn_remote_config = "01HMVMHCZZ8D0VTFWMRHBM5D6F"
  }

  endpoints = {
    pn      = "https://api-io.notifichedigitali.it"
    pn_test = "https://api-io.uat.notifichedigitali.it"
  }

  nonstandard = {
    weu = {
      asp  = "${var.project}-plan-appappbackend${var.name}"
      app  = "${var.project}-app-appbackend${var.name}"
      snet = "appbackend${var.name}"
    }
  }

}
