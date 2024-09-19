locals {
  autoscale_profiles = [
    {
      name = "{\"name\":\"default\",\"for\":\"evening\"}",

      recurrence = {
        hours   = 22
        minutes = 59
      }

      capacity = {
        default = var.autoscale.default + 1
        minimum = var.autoscale.minimum + 1
        maximum = var.autoscale.maximum
      }
    },
    {
      name = "{\"name\":\"default\",\"for\":\"night\"}",

      recurrence = {
        hours   = 5
        minutes = 0
      }

      capacity = {
        default = var.autoscale.default + 1
        minimum = var.autoscale.minimum + 1
        maximum = var.autoscale.maximum
      }
    },
    {
      name = "evening"

      recurrence = {
        hours   = 19
        minutes = 30
      }

      capacity = {
        default = var.autoscale.default + 2
        minimum = var.autoscale.minimum + 2
        maximum = var.autoscale.maximum
      }
    },
    {
      name = "night"

      recurrence = {
        hours   = 23
        minutes = 0
      }

      capacity = {
        default = var.autoscale.default
        minimum = var.autoscale.minimum
        maximum = var.autoscale.maximum
      }
    }
  ]
}