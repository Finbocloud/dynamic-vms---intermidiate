variable "rg_name" {
  description = "resourcegroup name"
  type        = string
  default     = "rg"
}
variable "owner" {
  description = "resource  owner"
  type        = string
  default     = "dynamic"
}
variable "environment" {
  description = "resource environment"
  type        = string
  default     = "vms"
}
variable "virtual_network" {
  description = "virtual network"
  type        = string
  default     = "vnet"
}
variable "location" {
  description = "resource location"
  type        = string
  default     = "uksouth"
}
variable "subnet" {
  description = "subnet name"
  type        = string
  default     = "internal"
}
variable "network_nic" {
  description = "network interface card"
  type        = string
  default     = "nic"
}
variable "public_ip" {
  description = "publicip address name"
  type        = string
  default     = "publicip"
}
variable "win_vm_name" {
  description = "windows vm name"
  type        = string
  default     = "vm"
}
variable "win_vm_username" {
  description = "Windows user name"
  type        = string
  default     = "adminuser"
}
variable "win_vm_password" {
  description = "Windows password"
  type        = string
  default     = "Password1234!"
}
variable "db_network_security_rule_name" {
  description = "database security rule name"
  type        = string
  default     = "db-nsg-rule"
}
variable "vm_network_security_rule_name" {
  description = "vm network security group rule"
  type        = string
  default     = "vm-nsg-rule"
}
variable "db_nsg_name" {
  description = "db network security group name"
  type        = string
  default     = "db-nsg-name"
}
variable "vm_nsg_name" {
  description = "vm network security group name"
  type        = string
  default     = "vm-nsg-name"
}
variable "keyvault_name" {
  description = "keayvault name"
  type        = string
  default     = "dynamickeyvault99389"
}
variable "usernames" {
  description = "keayvault name"
  type        = list(string)
  default     = ["rasheed"]
  # default can be chnaged to the below if the Quota (this needs to be reuested to be increased) can contacin it:
  # default = ["rasheed", "onas", "moji"]
}


