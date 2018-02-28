resource "azurerm_storage_account" "webappdemo_storage" {
   name 		= "webappdemosa"
   resource_group_name	= "${azurerm_resource_group.webappdemo_rg.name}"
   location		= "${var.location}"
   account_tier		= "Standard"
   account_replication_type	= "LRS"
   tags {
 	group = "WebAppDemo"
   }
}

resource "azurerm_storage_container" "webappdemo_storage_container" {
   name 			= "webappdemosc"
   resource_group_name  = "${azurerm_resource_group.webappdemo_rg.name}"
   storage_account_name		= "${azurerm_storage_account.webappdemo_storage.name}"
   container_access_type	= "private"
}
