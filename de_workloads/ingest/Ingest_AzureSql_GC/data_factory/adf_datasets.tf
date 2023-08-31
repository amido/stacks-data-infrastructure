resource "azurerm_data_factory_custom_dataset" "ds_AzureSql_GC" {
  name            = "ds_AzureSql_GC"
  data_factory_id = data.azurerm_data_factory.factory.id
  type            = "AzureSqlTable"
  folder          = "External_Sources"
  linked_service {
    name = azurerm_data_factory_linked_custom_service.ls_AzureSql_GC.name
  }
  type_properties_json = jsonencode({})
  schema_json          = jsonencode({})
}
