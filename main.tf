# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "thes-avd"
  location = "westeurope"
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "workspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "hostpool"
  location            = azurerm_resource_group.rg.location

  validate_environment     = false
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "BreadthFirst"

  custom_rdp_properties = "enablerdsaadauth:i:1;enablecredsspsupport:i:1;"
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = var.rfc3339
}

resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = azurerm_resource_group.rg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  location            = azurerm_resource_group.rg.location
  type                = "Desktop"
  name                = "dag"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool]
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "association" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}