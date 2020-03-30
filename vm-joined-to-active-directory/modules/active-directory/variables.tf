variable "resource_group_name" {
  description = "The name of the Resource Group where the Domain Controllers resources will be created"
}

variable "location" {
  description = "The Azure Region in which the Resource Group exists"
}

variable "prefix" {
  description = "The Prefix used for the Domain Controller's resources"
}

variable "subnet_id" {
  description = "The Subnet ID which the Domain Controller's NIC should be created in"
}

variable "active_directory_domain" {
  description = "The name of the Active Directory domain, for example `consoto.local`"
  default = "bustaramz.org"
}

variable "active_directory_netbios_name" {
  description = "The netbios name of the Active Directory domain, for example `consoto`"
  default = "BUSTARAMZ"
}

variable "admin_username" {
  description = "The username associated with the local administrator account on the virtual machine"
  default = "Admin-ramz"
}

variable "admin_password" {
  description = "The password associated with the local administrator account on the virtual machine"
  default = "An@is2013"
}

variable "OUpath_infra" {
  description = "The password associated with the local administrator account on the virtual machine"
  default = "DC=bustaramz,DC=org"
}

variable "OUpath_VDA" {
  description = "The password associated with the local administrator account on the virtual machine"
  default = "OU=Azure-Component,DC=bustaramz,DC=org"
}