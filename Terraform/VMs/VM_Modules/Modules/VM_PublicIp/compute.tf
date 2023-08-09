resource "azurerm_network_interface" "testnic" {
  name                = var.names.nic_name
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.testsubnet[var.subnet_index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.testpubip.id
  }
  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_virtual_network.testvnet,
    azurerm_subnet.testsubnet,
    azurerm_network_security_group.testnsg,
    azurerm_public_ip.testpubip
  ]
  tags = {
    environment = var.env
  }
}
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.testsubnet[var.subnet_index].id
  network_security_group_id = azurerm_network_security_group.testnsg.id
  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_virtual_network.testvnet,
    azurerm_subnet.testsubnet,
    azurerm_network_security_group.testnsg,
    azurerm_public_ip.testpubip,
    azurerm_network_interface.testnic
  ]
}

resource "azurerm_linux_virtual_machine" "testvm2" {
  name                = var.names.linux_vm_name
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = azurerm_resource_group.test-rg.location
  size                = var.vm_details.vm_size
  admin_username      = var.vm_details.admin_username
  #  admin_password                  = var.vm_details.admin_password

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_details.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.testnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_details.publisher
    offer     = var.vm_details.offer
    sku       = var.vm_details.sku
    version   = var.vm_details.version
  }

  #  custom_data = filebase64("apache.sh")

  
  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_virtual_network.testvnet,
    azurerm_subnet.testsubnet,
    azurerm_network_security_group.testnsg,
    azurerm_public_ip.testpubip,
    azurerm_network_interface.testnic
  ]
}

resource "null_resource" "executor" {
  triggers = {
    rollout_version = var.rollout
  }
  connection {
    type        = "ssh"
    user        = azurerm_linux_virtual_machine.testvm2.admin_username
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_linux_virtual_machine.testvm2.public_ip_address
  }

  # provisioner "file" {
  #   source      = "./apache.sh"
  #   destination = "/tmp/apache.sh"
  # }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install apache2 -y"
    ]
  }
}

