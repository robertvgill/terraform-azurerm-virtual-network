## network security group per subnet
resource "azurerm_network_security_group" "nsg" {
  for_each   = var.subnet_name
  depends_on = [azurerm_virtual_network.vnet]
  
  resource_group_name = format("%s", var.resource_group_name)
  location            = format("%s", var.location)

  name  = ("${var.network_security_group_name}-${each.key}")
  dynamic "security_rule" {
    for_each = concat(lookup(each.value, "nsg_inbound_rules", []), lookup(each.value, "nsg_outbound_rules", []))
    content {
      name                       = security_rule.value[0] == "" ? "Default_Rule" : security_rule.value[0]
      priority                   = security_rule.value[1]
      direction                  = security_rule.value[2] == "" ? "Inbound" : security_rule.value[2]
      access                     = security_rule.value[3] == "" ? "Allow" : security_rule.value[3]
      protocol                   = security_rule.value[4] == "" ? "TCP" : security_rule.value[4]
      source_port_range          = "*"
      destination_port_range     = security_rule.value[5] == "" ? "*" : security_rule.value[5]
      source_address_prefix      = security_rule.value[6] == "" ? element(each.value.subnet_address_prefix, 0) : security_rule.value[6]
      destination_address_prefix = security_rule.value[7] == "" ? element(each.value.subnet_address_prefix, 0) : security_rule.value[7]
      description                = "${security_rule.value[2]}_Port_${security_rule.value[5]}"
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

  tags = merge({ "Resource Name" = format("%s", var.network_security_group_name) }, var.tags, )
}

resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  for_each                  = var.subnet_name
  depends_on                = [
    azurerm_virtual_network.vnet,
  ]

  subnet_id                 = azurerm_subnet.snet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
