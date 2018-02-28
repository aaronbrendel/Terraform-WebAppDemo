resource "azurerm_network_security_group" "webappdemo_nsg_web" {
  name 			= "WebAppDemo-Web-NSG"
  location 		= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.webappdemo_rg.name}"

  security_rule {
	name 			= "AllowSSH"
	priority 		= 100
	direction 		= "Inbound"
	access 		        = "Allow"
	protocol 		= "Tcp"
	source_port_range       = "*"
    destination_port_range     	= "22"
    source_address_prefix      	= "*"
    destination_address_prefix 	= "*"
  }

  security_rule {
	name 			= "AllowHTTP"
	priority		= 200
	direction		= "Inbound"
	access 			= "Allow"
	protocol 		= "Tcp"
	source_port_range       = "*"
    destination_port_range     	= "80"
    source_address_prefix      	= "Internet"
    destination_address_prefix 	= "*"
  }

  tags {
	group = "WebAppDemo"
  }
}

resource "azurerm_network_security_group" "webappdemo_nsg_db" {
  name 			= "WebAppDemo-DB-NSG"
  location 		= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.webappdemo_rg.name}"

  security_rule {
	name 			= "BlockInternet"
	priority 		= 100
	direction 		= "Outbound"
	access 			= "Deny"
	protocol 		= "Tcp"
	source_port_range       = "*"
    destination_port_range     	= "*"
    source_address_prefix      	= "*"
    destination_address_prefix 	= "Internet"
  }

  security_rule {
	name 			= "AllowMySQL"
	priority		= 200
	direction		= "Inbound"
	access 			= "Allow"
	protocol 		= "Tcp"
	source_port_range       = "*"
    destination_port_range     	= "3306"
    source_address_prefix      	= "${var.subnet1_cidr}"
    destination_address_prefix 	= "*"
  }

  tags {
	group = "WebAppDemo"
  }
}
