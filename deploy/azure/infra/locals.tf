locals {

  ## Blob
  storage_account_blob_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.storage_account_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.description, azurerm_data_factory_managed_private_endpoint.blob_pe.name)
  ])

  ## Adls
  adls_account_dfs_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.adls_account_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.description, azurerm_data_factory_managed_private_endpoint.adls_pe.name)
  ])

  ## KV
  kv_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.kv_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.status, "Pending")
  ])

  ## SQL
  sql_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.sql_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.description, azurerm_data_factory_managed_private_endpoint.sql_pe.name)
  ])

  ## ADB
  adb_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.adb_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.description, azurerm_data_factory_managed_private_endpoint.db_pe.name)
  ])

  ## ADB auth
  adb_auth_private_endpoint_connection_name = one([
    for connection in jsondecode(data.azapi_resource.adb_private_endpoint_connection.output).properties.privateEndpointConnections
    : connection.name
    if
    endswith(connection.properties.privateLinkServiceConnectionState.description, azurerm_data_factory_managed_private_endpoint.db_auth_pe.name)
  ])
}
