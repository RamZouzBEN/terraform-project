locals {
  virtual_machine_name = "${var.prefix}-SEC"
}

resource "azurerm_virtual_machine" "sec" {
  name                          = "${local.virtual_machine_name}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  network_interface_ids         = ["${azurerm_network_interface.primary.id}"]
  vm_size                       = "Standard_D8_v3"
  delete_os_disk_on_termination = true

  storage_image_reference {
 id ="/subscriptions/3f536e12-d427-41c3-9629-666f8c013635/resourceGroups/templates-alsid/providers/Microsoft.Compute/images/myPackerALSID"
  }

  storage_os_disk {
    name              = "${local.virtual_machine_name}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.virtual_machine_name}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

}
