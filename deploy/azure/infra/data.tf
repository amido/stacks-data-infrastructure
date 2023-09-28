data "azurerm_client_config" "current" {}

data "azurerm_subnet" "pe_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}
/*
data "azurerm_private_dns_zone" "private_dns" {
  name                = var.dns_zone_namede
  resource_group_name = var.dns_zone_resource_group

}

*/

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "dfs_private_zone" {
  name                = var.dfs_private_zone
  resource_group_name = var.dns_zone_resource_group
}

data "azurerm_private_dns_zone" "blob_private_zone" {
  name                = var.blob_private_zone
  resource_group_name = var.dns_zone_resource_group
}

data "azurerm_private_dns_zone" "kv_private_dns_zone" {
  name                = var.kv_private_zone
  resource_group_name = var.dns_zone_resource_group
}

data "azurerm_private_dns_zone" "sql_private_dns_zone" {
  name                = var.sql_private_zone
  resource_group_name = var.dns_zone_resource_group
}

data "azurerm_private_dns_zone" "adb_private_dns_zone" {
  # count               = var.enable_private_network ? 1 : 0
  name                = var.adb_private_zone
  resource_group_name = var.dns_zone_resource_group
}

data "azapi_resource" "storage_account_private_endpoint_connection" {
  type                   = "Microsoft.Storage/storageAccounts@2022-09-01"
  resource_id            = module.adls_default.storage_account_ids[0]
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.blob_pe
  ]
}

data "azapi_resource" "adls_account_private_endpoint_connection" {
  type                   = "Microsoft.Storage/storageAccounts@2022-09-01"
  resource_id            = module.adls_default.storage_account_ids[1]
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.adls_pe
  ]
}

# data "azapi_resource" "kv_private_endpoint_connection" {
#   type                   = "Microsoft.Keyvault/vaults@2022-07-01"
#   resource_id            = module.kv_default.id
#   response_export_values = ["properties.privateEndpointConnections."]

#   depends_on = [
#     azurerm_data_factory_managed_private_endpoint.kv_pe
#   ]
# }

data "azapi_resource" "sql_private_endpoint_connection" {
  type                   = "Microsoft.Sql/servers@2021-11-01"
  resource_id            = module.sql.sql_server_id
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.sql_pe
  ]
}

data "azapi_resource" "adb_private_endpoint_connection" {
  type                   = "Microsoft.Databricks/workspaces@2023-02-01"
  resource_id            = module.adb.adb_databricks_id
  response_export_values = ["properties.privateEndpointConnections."]

  depends_on = [
    azurerm_data_factory_managed_private_endpoint.db_pe, azurerm_data_factory_managed_private_endpoint.db_auth_pe
  ]
}
