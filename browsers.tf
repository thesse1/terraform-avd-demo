resource "azurerm_virtual_desktop_workspace" "workspace_br" {
  name                = "workspace-br"
  friendly_name       = "Browsers"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_virtual_desktop_host_pool" "hostpool_br" {
  resource_group_name = azurerm_resource_group.rg.name
  name                = "hostpool-br"
  location            = azurerm_resource_group.rg.location

  validate_environment     = false
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "BreadthFirst"

  custom_rdp_properties = "enablerdsaadauth:i:1;enablecredsspsupport:i:1;"
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo_br" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool_br.id
  expiration_date = var.rfc3339
}

resource "azurerm_virtual_desktop_application_group" "dag_br" {
  resource_group_name = azurerm_resource_group.rg.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool_br.id
  location            = azurerm_resource_group.rg.location
  type                = "RemoteApp"
  name                = "dag-br"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool_br]
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "association_br" {
  application_group_id = azurerm_virtual_desktop_application_group.dag_br.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace_br.id
}

resource "azurerm_virtual_desktop_application" "edge" {
  name                         = "edge"
  application_group_id         = azurerm_virtual_desktop_application_group.dag_br.id
  friendly_name                = "Microsoft Edge"
  description                  = "Microsoft's standard web browser"
  path                         = "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe"
  command_line_argument_policy = "DoNotAllow"
  # command_line_arguments       = "--incognito"
  show_in_portal               = true
  icon_path                    = "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe"
  icon_index                   = 0
}