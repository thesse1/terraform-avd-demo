variable "rfc3339" {
type        = string
default     = "2026-03-01T12:43:13Z"
description = "Registration token expiration"
}

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

variable "rdsh_count_br" {
  description = "Number of AVD machines to deploy fpr Browsers"
  default     = 2
}

variable "rdsh_count_dt" {
  description = "Number of AVD machines to deploy for Desktops"
  default     = 2
}

variable "prefix" {
  type        = string
  default     = "avdtf"
  description = "Prefix of the name of the network resources"
}

variable "prefix_br" {
  type        = string
  default     = "avdtf-br"
  description = "Prefix of the name of the AVD machine(s) for Browsers"
}

variable "prefix_dt" {
  type        = string
  default     = "avdtf-dt"
  description = "Prefix of the name of the AVD machine(s) for Desktops"
}

variable "vm_size" {
  description = "Size of the machine to deploy"
  default     = "Standard_DS2_v2"
}

variable "local_admin_username" {
  type        = string
  default     = "localadm"
  description = "local admin username"
}

variable "local_admin_password" {
  type        = string
  default     = "ChangeMe123!"
  description = "local admin password"
  sensitive   = true
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