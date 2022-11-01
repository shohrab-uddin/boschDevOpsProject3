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
  admin_username      = "azureuser"
  network_interface_ids = [azurerm_network_interface.test.id,]
  admin_ssh_key {
    username   = "azureuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYpY5JB4l5VTH7lBBqOYDRgMocmVFck/EmqniCW+oDw2MGr3RY5hjn6hS7gIHJr+OKCfY/5mX+7f2jY0tZ/NFRHtR+eBjoODWiWJJ/EmZY+zTxSJ0LxttbTqJd7afnAVfu3/fMCvcr7u4KqVPK/1SMVnLXvY16XFE2cv1s8/Zzf3exIi/oIkWeh903m74cbqx4F03ylZyc2kCFnDG+Xz7eMJtVQC/IBJjbgnaHYMmh8MlBPvZNm/2tZ2iJzLUAgAHrtcuMMPtIHv8bkMa4YxfcX3BwJZrIZhiL59rk4X4OSBxt33FSWauFNUzV2LXU2cWAbKqg3zZDOD8SaPfXQ8yf"
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
