resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "${var.prefix}-workspace"
  friendly_name       = var.workspace_friendly_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name = var.resource_group_name
  name                = "${var.prefix}-hostpool"
  location            = var.location

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

resource "azurerm_virtual_desktop_application_group" "appgroup" {
  resource_group_name = var.resource_group_name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  location            = var.location
  type                = var.application_group_type
  name                = "${var.prefix}-appgroup"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool]
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "association" {
  application_group_id = azurerm_virtual_desktop_application_group.appgroup.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}