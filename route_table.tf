## route table
data "azurerm_route_table" "rt" {
  count = var.route_table_create ? 0 : 1

  name                 = format("%s", var.route_table)
  resource_group_name  = format("%s", var.resource_group_name)
}

resource "azurerm_route_table" "rt" {
  for_each            = var.route_table

  depends_on          = [
    azurerm_virtual_network.vnet,
  ] 

  name                          = each.value.name
  location                      = format("%s", var.location)
  resource_group_name           = format("%s", var.resource_group_name)
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
  dynamic "route" {
    for_each                    = each.value.route_entries
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = contains(keys(route.value), "next_hop_in_ip_address") ? route.value.next_hop_in_ip_address: null
    }
  }
}
/**
resource "azurerm_subnet_route_table_association" "rtassoc" {
  for_each = {
    for subnet in var.subnet_name:
      subnet.name => subnet.id
  }

  subnet_id      = azurerm_subnet.snet[each.key].id
  route_table_id = azurerm_route_table.rt[each.key].id
}
**/