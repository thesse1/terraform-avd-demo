output "workspace_id" {
  value = azurerm_virtual_desktop_workspace.workspace.id
}

output "hostpool_id" {
  value = azurerm_virtual_desktop_host_pool.hostpool.id
}

output "appgroup_id" {
  value = azurerm_virtual_desktop_application_group.appgroup.id
}