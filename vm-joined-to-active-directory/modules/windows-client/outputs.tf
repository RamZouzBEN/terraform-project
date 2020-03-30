output "public_ip_address" {

	depends_on = ["azurerm_virtual_machine.client"]
  value = ["${azurerm_public_ip.static.ip_address}"]
}
