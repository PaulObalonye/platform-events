resource "azurerm_resource_group" "platform-events" {
  name     = "platform-events"
  location = "West Europe"
}

resource "azurerm_container_registry" "cardinalhealthUAT" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.platform-events.name
  location            = azurerm_resource_group.platform-events.location
  sku                 = "Premium"
  admin_enabled       = false
}

resource "azurerm_servicebus_namespace" "PlatformEventsBusUAT" {
  name                = var.servicebus_namespace
  location            = azurerm_resource_group.platform-events.location
  resource_group_name = azurerm_resource_group.platform-events.name
  sku                 = "Standard"

  tags = {
    source = "terraform"
  }
}

resource "azurerm_log_analytics_workspace" "PlatformEventsLogUAT" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.platform-events.location
  resource_group_name = azurerm_resource_group.platform-events.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_storage_account" "platformeventsUAT" {
  name                     = var.storageaccount_name
  resource_group_name      = azurerm_resource_group.platform-events.name
  location                 = azurerm_resource_group.platform-events.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "UAT"
  }
}