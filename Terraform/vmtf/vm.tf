resource "azurerm_network_interface" "vmnic" {
  name                = var.names.test_vm_nic_name
  location            = azurerm_resource_group.testrg.location
  resource_group_name = azurerm_resource_group.testrg.name
  ip_configuration {
    name                          = "vmnic_ip"
    subnet_id                     = azurerm_subnet.subnets[var.subnet_index].id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_resource_group.testrg,
    azurerm_subnet.subnets
  ]

}

resource "azurerm_linux_virtual_machine" "testvm" {
  name                            = var.names.test_vm_name
  location                        = azurerm_resource_group.testrg.location
  resource_group_name             = azurerm_resource_group.testrg.name
  size                            = "Standard_B1s"
  admin_username                  = "Dell"
  admin_password                  = "WelcometoJungle@123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vmnic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  depends_on = [
    azurerm_resource_group.testrg,
    azurerm_subnet.subnets,
    azurerm_network_interface.vmnic
  ]

}