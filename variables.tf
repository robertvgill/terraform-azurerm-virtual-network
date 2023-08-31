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

variable "subnet_name" {
  description = "For each subnet, create an object that contain fields."
  default     = {}
}

variable "network_security_group_name" {
  description = "The name of the network security group."
  type        = string
  default     = null
}

variable "route_table" {
  description = "For each route table, create an object that contain fields."
  default     = {}
}

variable "route_table_create" {
  type        = string
  default     = false
}

variable "disable_bgp_route_propagation" {
  description = "(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}