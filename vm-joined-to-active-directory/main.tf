provider "azurerm" {
  version = "=1.1.2"
  
        client_id = "fd8e5649-0049-44ad-bcbd-b67b9093090e",
      client_secret = "el=?9IWV/nN=hZAR1PjXRMsblkrjkW38",
      subscription_id = "3f536e12-d427-41c3-9629-666f8c013635",
      tenant_id = "edfc0356-4c76-4358-9e14-3677b43ae949"
  
}

locals {
  resource_group_name = "${var.prefix}-resources"
}

resource "azurerm_resource_group" "test" {
  name     = "${local.resource_group_name}"
  location = "Japan East"
}

module "network" {
  source              = "./modules/network"
  prefix              = "${var.prefix}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "${azurerm_resource_group.test.location}"
}

module "active-directory-domain" {
  source                        = "./modules/active-directory"
  resource_group_name           = "${azurerm_resource_group.test.name}"
  location                      = "${azurerm_resource_group.test.location}"
  prefix                        = "${var.prefix}"
  subnet_id                     = "${module.network.domain_controllers_subnet_id}"
  active_directory_domain       = "Bustaramz.org"
  active_directory_netbios_name = "Bustaramz"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
}

module "windows-client" {
  source                    = "./modules/windows-client"
  resource_group_name       = "${azurerm_resource_group.test.name}"
  location                  = "${azurerm_resource_group.test.location}"
  prefix                    = "${var.prefix}"
  subnet_id                 = "${module.network.domain_clients_subnet_id}"
  active_directory_domain   = "Bustaramz.org"
  active_directory_username = "${var.admin_username}"
  active_directory_password = "${var.admin_password}"
  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
}


#module "storage-manager" {
#  source                    = "./modules/storage-manager"
#  resource_group_name       = "${azurerm_resource_group.test.name}"
#  location                  = "${azurerm_resource_group.test.location}"
#  prefix                    = "${var.prefix}"
#  subnet_id                 = "${module.network.domain_controllers_subnet_id}"
#  active_directory_domain   = "Bustaramz.org"
#  active_directory_username = "${var.admin_username}"
#  active_directory_password = "${var.admin_password}"
#  admin_username            = "${var.admin_username}"
#  admin_password            = "${var.admin_password}"
#}
#
#module "security-engine" {
#  source                    = "./modules/security-engine"
#  resource_group_name       = "${azurerm_resource_group.test.name}"
#  location                  = "${azurerm_resource_group.test.location}"
#  prefix                    = "${var.prefix}"
#  subnet_id                 = "${module.network.domain_controllers_subnet_id}"
#  active_directory_domain   = "Bustaramz.org"
#  active_directory_username = "${var.admin_username}"
#  active_directory_password = "${var.admin_password}"
#  admin_username            = "${var.admin_username}"
#  admin_password            = "${var.admin_password}"
#}
#
#
module "ad-listener" {
  source                    = "./modules/ad-listener"
  resource_group_name       = "${azurerm_resource_group.test.name}"
  location                  = "${azurerm_resource_group.test.location}"
  prefix                    = "${var.prefix}"
  subnet_id                 = "${module.network.domain_controllers_subnet_id}"
  active_directory_domain   = "Bustaramz.org"
  active_directory_username = "${var.admin_username}"
  active_directory_password = "${var.admin_password}"
  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
}

output "windows_client_public_ip" {
  value = "${module.windows-client.public_ip_address}"
}
