resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "odl_user_213860"
  network_interface_ids = [azurerm_network_interface.test.id,]
  admin_ssh_key {
    username   = "odl_user_213860"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCoUHOYxzfKDAeTeOqbja1BQWGaOFqkNgWrIhkxwsSJoj+716oyrslVqEml3Eq5habvEAUmWEKFHXyCsRBT+pwon91o37v2FdP4WDdpZ0h/4zKGFOWn7yOkfjuTYvVA5RK/E8UtxlKyyQUkTedIOM5rhAZPO2lqe7NswCkfWqLV8AVBeMQyq/QutBCRe4k6MbHSRqpAwo4kU+r8Se7yHNEnCqwGNse5Zsjex1m0OqIyhTccs/x9reHKEU1wAHf8pHKrkO8NP92psPWGlJVYW3CyxXA0XJdWfP81PYEciHhI7gqy/UEuO2uwlQUJf6jF8jLYZHwLC+9DG4x0r3jp/5H"
    #public_key = file(var.vm_public_key) 
     
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
