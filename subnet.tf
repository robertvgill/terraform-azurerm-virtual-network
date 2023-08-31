## subnet
data "azurerm_subnet" "snet" {
  count = var.virtual_network_create ? 0 : 1

  name                 = format("%s", var.subnet_name)
  virtual_network_name = format("%s", var.virtual_network_name)
  resource_group_name  = format("%s", var.resource_group_name)
}

resource "azurerm_subnet" "snet" {
  for_each            = var.subnet_name

  depends_on          = [
    azurerm_virtual_network.vnet,
  ] 

  name                                           = each.value.name
  resource_group_name                            = format("%s", var.resource_group_name)
  virtual_network_name                           = each.value.virtual_network_name
  address_prefixes                               = each.value.subnet_address_prefix
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "private_endpoint_network_policies_enabled", null)
  enforce_private_link_service_network_policies  = lookup(each.value, "private_link_service_network_policies_enabled", null)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []
    content {
      name = lookup(each.value.delegation, "name", null)
      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
