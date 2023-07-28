resource "azurerm_resource_group" "test-rg" {
  name     = var.names.resource_group_name
  location = var.rglocation
}

resource "azurerm_virtual_network" "testvnet" {
  name                = var.names.vnet_name
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name
  address_space       = var.address_space

  tags = {
    environment = var.env
  }

  depends_on = [azurerm_resource_group.test-rg]
}

resource "azurerm_subnet" "testsubnet" {
  count                = length(var.subnet_names)
  name                 = var.names.subnet_name
  resource_group_name  = azurerm_resource_group.test-rg.name
  virtual_network_name = azurerm_virtual_network.testvnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]
  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_virtual_network.testvnet
  ]
}

resource "azurerm_network_security_group" "testnsg" {
  name                = var.names.nsg_name
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  security_rule {
    name                       = "AllowAll"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_virtual_network.testvnet,
    azurerm_subnet.testsubnet
  ]
}

resource "azurerm_public_ip" "testpubip" {
  name                = var.names.public_ip_name
  resource_group_name = azurerm_resource_group.test-rg.name
  location            = azurerm_resource_group.test-rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.test-rg,
    azurerm_virtual_network.testvnet,
    azurerm_subnet.testsubnet,
    azurerm_network_security_group.testnsg
  ]
}

