
resource "azurerm_network_interface" "primary" {
  name                    = "${var.prefix}-STORM-nic"
  location                = "${var.location}"
  resource_group_name     = "${var.resource_group_name}"
  internal_dns_name_label = "${local.virtual_machine_name}"

  ip_configuration {
    name                          = "primary"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.5"
  }
}