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
}
