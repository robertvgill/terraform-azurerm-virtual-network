## virtual network
output "virtual_network_name" {
  description = "Name of virtual network created."
  value = values(azurerm_virtual_network.vnet)[*].name
}

output "subnet_name" {
  description = "Name of subnet created."
  value = values(azurerm_subnet.snet)[*].name
}

output "network_security_group_name" {
  description = "Name of network security group created."
  value = values(azurerm_network_security_group.nsg)[*].name
}

output "route_table_name" {
  description = "Name of network route created."
  value = values(azurerm_route_table.rt)[*].name
}