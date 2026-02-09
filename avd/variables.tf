variable "resource_group_name" {}

variable "location" {}

variable "rfc3339" {
type        = string
default     = "2026-03-01T12:43:13Z"
description = "Registration token expiration"
}

variable "rdsh_count" {
  description = "Number of AVD machines to deploy"
}

variable "workspace_friendly_name" {
  description = "Friendly name of the workspace resource"
}

variable "application_group_type" {
  description = "Type of the application group (Desktop or RemoteApp)"
}

variable "prefix" {
  description = "Prefix of the name of AVD resources"
}

variable "vm_size" {
  description = "Size of the machine to deploy"
  default     = "Standard_DS2_v2"
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

variable "subnet_id" {}