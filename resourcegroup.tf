resource "azurerm_resource_group" "webappdemo_rg" {
   name		= "${var.resource_group_name}"
   location 	= "${var.location}"
}

