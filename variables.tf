variable "vnet_range" {
  type        = list(string)
  default     = ["10.2.0.0/16"]
  description = "Address range for deployment VNet"
}
variable "subnet_range" {
  type        = list(string)
  default     = ["10.2.0.0/24"]
  description = "Address range for session host subnet"
}

variable "rdsh_count_apps" {
  description = "Number of AVD machines to deploy for Applications"
  default     = 2
}

variable "rdsh_count_dt" {
  description = "Number of AVD machines to deploy for Desktops"
  default     = 2
}

variable "local_admin_username" {
  type        = string
  description = "local admin username"
}

variable "local_admin_password" {
  type        = string
  description = "local admin password"
  sensitive   = true
}

variable "prefix" {
  type        = string
  default     = "avd"
  description = "Prefix of the name of the network resources"
}

variable "prefix_apps" {
  type        = string
  default     = "avd-apps"
  description = "Prefix of the name of the AVD resources for Applications"
}

variable "prefix_dt" {
  type        = string
  default     = "avd-dt"
  description = "Prefix of the name of the AVD resources for Desktops"
}

# variable "avd_users" {
#   description = "AVD users"
#   default = [
#     "thomas.hesse2@ibm.com"
#   ]
# }

# variable "aad_group_name" {
#   type        = string
#   default     = "AVDUsers"
#   description = "Azure Active Directory Group for AVD users"
# }