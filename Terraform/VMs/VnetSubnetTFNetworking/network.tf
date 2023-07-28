resource "azurerm_resource_group" "testrg" {
  name     = var.names.resource_group_name
  location = var.rglocation
}

resource "azurerm_virtual_network" "testvnetprimary" {
  name                = var.vnetnames.primary
  location            = var.vnetlocations.primary
  resource_group_name = azurerm_resource_group.testrg.name
  address_space       = var.address_space
  depends_on          = [azurerm_resource_group.testrg]
  tags = {
    Env       = "Dev"
    CreatedBy = "terraform"
    Pair      = "secondary"
  }

}

resource "azurerm_virtual_network" "testvnetsecondary" {
  name                = var.vnetnames.secondary
  location            = var.vnetlocations.secondary
  resource_group_name = azurerm_resource_group.testrg.name
  address_space       = var.address_space
  depends_on          = [azurerm_resource_group.testrg]
  tags = {
    Env       = "Dev"
    CreatedBy = "terraform"
    Pair      = "Primary"
  }

}

resource "azurerm_subnet" "subnetsprimary" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvnetprimary.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]
  depends_on           = [azurerm_virtual_network.testvnetprimary]

}
resource "azurerm_subnet" "subnetssecondary" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvnetsecondary.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]
  depends_on           = [azurerm_virtual_network.testvnetsecondary]

}

resource "azurerm_network_security_group" "nsgprimary" {
  name = var.names.nsg_primary
  location = var.vnetlocations.primary
  resource_group_name = var.names.resource_group_name
  security_rule {
    name                       = "all"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.names.env_name
  }
  depends_on = [ 
    azurerm_virtual_network.testvnetprimary,
    aazurerm_subnet.subnetsprimary
   ]
}

resource "azurerm_network_security_group" "nsgsecondary" {
    name = var.names.nsg_secondary
  location = var.vnetlocations.secondary
  resource_group_name = azurerm_resource_group.testrg.name
  security_rule {
    name                       = "all"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.names.env_name
  }
  depends_on = [ 
    azurerm_virtual_network.testvnetsecondary,
    aazurerm_subnet.subnetssecondary
   ] 
}

resource "azurerm_network_security_rule" "nsgruleprimary" {
  name = var.names.secruleprimary
  priority = 550
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.testrg.name
  network_security_group_name = azurerm_network_security_group.nsgprimary.name
  
}

resource "azurerm_network_security_rule" "nsgrulesecondary" {
  name = var.names.secrulesecondary
  priority = 550
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.testrg.name
  network_security_group_name = azurerm_network_security_group.nsgprimary.name
  
}