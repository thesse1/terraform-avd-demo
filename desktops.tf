resource "azurerm_virtual_desktop_workspace" "workspace_dt" {
  name                = "workspace-dt"
  friendly_name       = "Desktops"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_virtual_desktop_host_pool" "hostpool_dt" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "hostpool-dt"
  location            = azurerm_resource_group.rg.location

  validate_environment     = false
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "BreadthFirst"

  custom_rdp_properties = "enablerdsaadauth:i:1;enablecredsspsupport:i:1;"
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo_dt" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool_dt.id
  expiration_date = var.rfc3339
}

resource "azurerm_virtual_desktop_application_group" "dag_dt" {
  resource_group_name = azurerm_resource_group.rg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool_dt.id
  location            = azurerm_resource_group.rg.location
  type                = "Desktop"
  name                = "dag-dt"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool_dt]
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "association_dt" {
  application_group_id = azurerm_virtual_desktop_application_group.dag_dt.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace_dt.id
}