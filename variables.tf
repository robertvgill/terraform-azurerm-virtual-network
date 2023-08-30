## resource group
variable "resource_group_create" {
  description = "Controls if resource group should be created."
  type        = bool
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource should be created."
  type        = string
}

## virtual network
variable "virtual_network_create" {
  description = "Controls if networking resources should be created."
  type        = bool
}

variable "virtual_network_name" {
  description = "The name of the Azure virtual network."
  default     = {}
}

variable "nw_address_space" {
  description = "The address space to be used for the Azure virtual network."
  default     = []
}

variable "nw_dns_servers" {
  description = "List of dns servers to use for the Azure virtual network."
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}