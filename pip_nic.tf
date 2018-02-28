resource "azurerm_public_ip" "webappdemo_pip" {
  name 				= "WebAppDemo-PIP"
  location 			= "${var.location}"
  resource_group_name 		= "${azurerm_resource_group.webappdemo_rg.name}"
  public_ip_address_allocation 	= "static"

  tags {
	group = "LinuxAcademy"
  }
}

resource "azurerm_network_interface" "public_nic" {
  name 		      = "WebAppDemo-Web-Nic"
  location 	      = "${var.location}"
  resource_group_name = "${azurerm_resource_group.webappdemo_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.webappdemo_nsg_web.id}"

  ip_configuration {
    name 			= "WebAppDemo-WebPrivate"
    subnet_id 			= "${azurerm_subnet.webappdemo_subnet_1.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id	= "${azurerm_public_ip.webappdemo_pip.id}"
  }
  tags {
	group = "WebAppDemo"
  }
}

resource "azurerm_public_ip" "webappdemo_db_pip" {
  name                  = "WebAppDemo-DB-PIP"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.webappdemo_rg.name}"
  public_ip_address_allocation = "static"

  tags {
        group = "WebAppDemo"
  }
}

resource "azurerm_network_interface" "private_nic" {
  name 			= "WebAppDemo-DB"
  location 		= "${var.location}"
  resource_group_name 	= "${azurerm_resource_group.webappdemo_rg.name}"
  network_security_group_id = "${azurerm_network_security_group.webappdemo_nsg_db.id}"

  ip_configuration {
    name 			= "WebAppDemo-DBPrivate"
    subnet_id 			= "${azurerm_subnet.webappdemo_subnet_2.id}"
    private_ip_address_allocation = "static"
    private_ip_address = "192.168.2.5"
    public_ip_address_id        = "${azurerm_public_ip.webappdemo_db_pip.id}"
  }
  tags {
	group = "WebAppDemo"
  }
}
