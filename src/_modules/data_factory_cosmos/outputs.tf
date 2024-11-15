output "pipelines" {
  value = {
    for pipeline in azurerm_data_factory_pipeline.pipeline
    : pipeline.name => {
      id   = pipeline.id
      name = pipeline.name
      url  = "https://adf.azure.com/en/authoring/pipeline/${pipeline.name}?factory=${pipeline.data_factory_id}"
    }
  }
}