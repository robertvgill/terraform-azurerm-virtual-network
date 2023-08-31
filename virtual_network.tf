## virtual network
data "azurerm_virtual_network" "vnet" {
  count = var.virtual_network_create ? 0 : 1

  name                = format("%s", var.virtual_network_name)
  resource_group_name = format("%s", var.resource_group_name)
}

resource "azurerm_virtual_network" "vnet" {
  for_each = var.virtual_network_name

  resource_group_name = format("%s", var.resource_group_name)
  location            = format("%s", var.location)

  name                = each.value.name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers

  lifecycle {
    prevent_destroy = false
  }

  tags = merge({ "Resource Name" = format("%s", each.value.name) }, var.tags, )
}