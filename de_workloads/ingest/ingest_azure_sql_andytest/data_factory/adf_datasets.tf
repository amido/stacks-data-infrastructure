resource "azurerm_data_factory_custom_dataset" "ds_azure_sql_andytest" {
  name            = "ds_azure_sql_andytest"
  data_factory_id = data.azurerm_data_factory.factory.id
  type            = "AzureSqlTable"
  folder          = "External_Sources"
  linked_service {
    name = azurerm_data_factory_linked_custom_service.ls_azure_sql_andytest.name
  }
  type_properties_json = jsonencode({})
  schema_json          = jsonencode({})
}
