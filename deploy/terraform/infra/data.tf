data "azurerm_client_config" "current" {}

# Obtain some environment variables that can be used in the terraform configuration
# This is primarily used to get the name of the environment being deployed
data "external" "env" {
  program = ["${path.module}/scripts/env.sh"]
}

data "azurerm_subnet" "pe_subnet" {
  count                = var.enable_private_networks ? 1 : 0
  name                 = var.pe_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

# Get the data for the build_agent_subnet to allow the ADO to access the key vault
data "azurerm_subnet" "build_agent_subnet" {
  count                = var.enable_private_networks ? 1 : 0
  name                 = var.build_agent_subnet_name
  virtual_network_name = var.hub_vnet_name
  resource_group_name  = var.hub_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  count               = var.enable_private_networks ? 1 : 0
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_private_dns_zone" "dfs_private_zone" {
  count               = var.enable_private_networks ? 1 : 0
  name                = var.dfs_private_zone
  resource_group_name = var.dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "blob_private_zone" {
  count               = var.enable_private_networks ? 1 : 0
  name                = var.blob_private_zone
  resource_group_name = var.dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "kv_private_dns_zone" {
  count               = var.enable_private_networks ? 1 : 0
  name                = var.kv_private_zone
  resource_group_name = var.dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "sql_private_dns_zone" {
  count               = var.enable_private_networks ? 1 : 0
  name                = var.sql_private_zone
  resource_group_name = var.dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "adb_private_dns_zone" {
  count               = var.enable_private_networks ? 1 : 0
  name                = var.adb_private_zone
  resource_group_name = var.dns_zone_resource_group_name
}

# Enable diagnostic settings for ADF
data "azurerm_monitor_diagnostic_categories" "adf_log_analytics_categories" {
  resource_id = module.adf.adf_factory_id
}

# Get the UUID of the Azure DevOps project, if it is being updated
data "azuredevops_project" "ado" {
  count = var.enable_private_networks && var.ado_create_variable_group ? 1 : 0
  name  = var.ado_project_id
}
