resource "azurerm_resource_group_template_deployment" "pipeline_processing_andytest" {
  name                = "pipeline_processing_andytest"
  resource_group_name = var.data_factory_resource_group_name
  deployment_mode     = var.arm_deployment_mode
  parameters_content = jsonencode({
    "factoryName" = {
      value = data.azurerm_data_factory.factory.name
    }
  })
  template_content = file("${path.module}/pipelines/arm_template.json")
}
