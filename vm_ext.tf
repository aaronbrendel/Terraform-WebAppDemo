resource "azurerm_virtual_machine_extension" "cs_apache" {
  name 			= "custom_apache"
  location 		= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.webappdemo_rg.name}"
  virtual_machine_name  = "${azurerm_virtual_machine.webappdemo_web.name}"
  publisher 		= "Microsoft.OSTCExtensions"
  type 			= "CustomScriptForLinux"
  type_handler_version  = "1.2"

  settings = <<SETTINGS
  {
	"fileUris": [
	"https://raw.githubusercontent.com/aaronbrendel/Terraform-WebAppDemo/master/scripts/apache_php_install.sh"
	],
	"commandToExecute": "sh "
  }
SETTINGS

  tags {
	group = "WebAppDemo"
  }
}

resource "azurerm_virtual_machine_extension" "cs_mysql" {
  name 			= "custom_mysql"
  location 		= "${var.location}"
  resource_group_name   = "${azurerm_resource_group.webappdemo_rg.name}"
  virtual_machine_name  = "${azurerm_virtual_machine.webappdemo_db.name}"
  publisher 		= "Microsoft.OSTCExtensions"
  type 			= "CustomScriptForLinux"
  type_handler_version  = "1.2"

  settings = <<SETTINGS
  {
	"fileUris": [
	"https://raw.githubusercontent.com/aaronbrendel/Terraform-WebAppDemo/master/scripts/mysql_install.sh"
	],
	"commandToExecute": "sh "
  }
SETTINGS

  tags {
	group = "WebAppDemo"
  }
}
