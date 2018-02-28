resource "azurerm_virtual_network" "webappdemo_vnet" {
   name			= "webappdemo-VNet"
   address_space 	= ["${var.vnet_cidr}"]
   location		= "${var.location}"
   resource_group_name	= "${azurerm_resource_group.webappdemo_rg.name}"
   tags {
	group = "WebAppDemo"
   }
}

resource "azurerm_subnet" "webappdemo_subnet_1" {
  name 			= "webappdemo-Subnet-1"
  address_prefix 	= "${var.subnet1_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.webappdemo_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.webappdemo_rg.name}"
}

resource "azurerm_subnet" "webappdemo_subnet_2" {
  name 			= "webappdemo-Subnet-2"
  address_prefix 	= "${var.subnet2_cidr}"
  virtual_network_name 	= "${azurerm_virtual_network.webappdemo_vnet.name}"
  resource_group_name 	= "${azurerm_resource_group.webappdemo_rg.name}"
}
