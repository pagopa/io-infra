resource "azurerm_resource_group" "github_runner" {
  name     = "${local.project}-github-runner-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_subnet" "github_runner" {
  name                 = "${local.project}-github-runner-snet"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
  address_prefixes     = ["10.0.242.0/23"]
  service_endpoints = [
    "Microsoft.Web",
  ]
}

module "github_runner" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_app_environment?ref=v6.15.0"

  name                      = "${local.project}-github-runner-cae"
  resource_group_name       = azurerm_resource_group.github_runner.name
  location                  = var.location
  vnet_internal             = true
  subnet_id                 = azurerm_subnet.github_runner.id
  log_destination           = "log-analytics"
  log_analytics_customer_id = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  log_analytics_shared_key  = azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
  zone_redundant            = true

  tags = var.tags
}

locals {
  repo_owner = "PagoPA"
  repo_name = "io-infra"
  container_registry_name = "andreagacr01"
  image_name = "github-actions-runner:1.0"
}

resource "azapi_resource" "job" {
  type      = "Microsoft.App/jobs@2023-05-01"
  name      = "io-infra-github-runner-job"
  location  = var.location
  parent_id = azurerm_resource_group.github_runner.id

  body = jsonencode({
    properties = {
      configuration = {
        registries = [
          {
            server            = "${local.container_registry_name}.azurecr.io"
            username          = local.container_registry_name
            passwordSecretRef = "${local.container_registry_name}azurecrio-${local.container_registry_name}"
          }
        ]
        replicaRetryLimit = 1
        replicaTimeout    = 1800
        eventTriggerConfig = {
          parallelism            = 1
          replicaCompletionCount = 1
          scale = {
            maxExecutions   = 5
            minExecutions   = 0
            pollingInterval = 20
            rules = {
              name = "github-runner"
              type = "github-runner"
              metadata = {
                github_runner             = "https://api.github.com"
                owner                     = local.repo_owner
                runnerScope               = "repo"
                repos                     = local.repo_name
                targetWorkflowQueueLength = "1"
              }
              auth = [
                {
                  secretRef        = "personal-access-token"
                  triggerParameter = "personalAccessToken"
                }
              ]
            }
          }
        }
        secrets = [
          {
            name  = "personal-access-token"
            value = "${var.TF_ACR_PASSWORD}"
          },
          {
            name = "${local.container_registry_name}azurecrio-${local.container_registry_name}"
          }
        ]
        triggerType = "Event"
      }
      environmentId = module.github_runner.id
      template = {
        containers = [
          {
            env = [
              {
                name      = "GITHUB_PAT"
                secretRef = "personal-access-token"
              },
              {
                name  = "REPO_URL"
                value = "https://github.com/${local.repo_owner}/${repo_name}"
              },
              {
                name  = "REGISTRATION_TOKEN_API_URL"
                value = "https://api.github.com/repos/${local.repo_owner}/${repo_name}/actions/runners/registration-token"
              }
            ]
            image = "${local.container_registry_name}.azurecr.io/${local.image_name}"
            name  = "github-actions-runner-job"
            resources = {
              cpu    = "0.5"
              memory = "1Gi"
            }
          }
        ]
      }
    }
  })
}
