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

module "avd_apps" {
  source = "./avd"

  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  subnet_id = azurerm_subnet.subnet.id
  application_group_type = "RemoteApp"
  prefix = var.prefix_apps
  workspace_friendly_name = "Applications"
  rdsh_count = var.rdsh_count_apps
  local_admin_password = var.local_admin_password
  local_admin_username = var.local_admin_username
}

module "avd_dt" {
  source = "./avd"

  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  subnet_id = azurerm_subnet.subnet.id
  application_group_type = "Desktop"
  prefix = var.prefix_dt
  workspace_friendly_name = "Desktops"
  rdsh_count = var.rdsh_count_dt
  local_admin_password = var.local_admin_password
  local_admin_username = var.local_admin_username
}