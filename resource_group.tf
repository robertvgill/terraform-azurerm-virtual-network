## resource group
data "azurerm_resource_group" "rg" {
  count = var.resource_group_create ? 0 : 1

  name  = format("%s", var.resource_group_name)
}

resource "azurerm_resource_group" "rg" {
  count = var.resource_group_create ? 1 : 0

  name     = format("%s", var.resource_group_name)
  location = format("%s", var.location)

  lifecycle {
    prevent_destroy = false
  }

  tags = merge({ "Resource Name" = format("%s", var.resource_group_name) }, var.tags, )
}