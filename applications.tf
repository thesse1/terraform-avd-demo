resource "azurerm_virtual_desktop_application" "edge" {
  name                         = "edge"
  application_group_id         = module.avd_apps.appgroup_id
  friendly_name                = "Microsoft Edge"
  description                  = "Microsoft's standard web browser"
  path                         = "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe"
  command_line_argument_policy = "DoNotAllow"
  # command_line_arguments       = "--incognito"
  show_in_portal               = true
  icon_path                    = "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe"
  icon_index                   = 0
}