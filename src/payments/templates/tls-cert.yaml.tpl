namespace: '${namespace}'

image:
  repository: '${image_name}'
  tag: '${image_tag}'

ingress:
  create: false

service:
  create: false

resources:
  requests:
    memory: '96Mi'
    cpu: '10m'
  limits:
    memory: '128Mi'
    cpu: '50m'

envConfig:
  WEBSITE_SITE_NAME: '${website_site_name}'
  FUNCTION_WORKER_RUNTIME: 'dotnet'
  TIME_TRIGGER: '${time_trigger}'
  FunctionName: '${function_name}'
  Region: '${region}'
  ExpirationDeltaInDays: '${expiration_delta_in_days}'
  Host: 'https://${host}'

envSecret:
  APPINSIGHTS_INSTRUMENTATIONKEY: '${appinsights_instrumentationkey}'
  AzureWebJobsStorage: '${azure_web_jobs_storage}'

keyvault:
  name: '${keyvault_name}'
  tenantId: '${keyvault_tenantid}'
