output "pipelines" {
    value = {
        for pipeline in concat(azurerm_data_factory_pipeline.pipeline_container, azurerm_data_factory_pipeline.pipeline_table)
        : pipeline.name => {
            id = pipeline.id
            name = pipeline.name
            url = "https://adf.azure.com/en/authoring/pipeline/${pipeline.name}?factory=${pipeline.data_factory_id}"
        }
    }
}