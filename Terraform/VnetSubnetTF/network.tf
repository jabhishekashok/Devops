resource "azurerm_resource_group" "testrg" {
  name     = "test-rg"
  location = var.location
}

resource "azurerm_virtual_network" "testvnet" {
  name                = "testvnet"
  location            = azurerm_resource_group.testrg.location
  resource_group_name = azurerm_resource_group.testrg.name
  address_space       = var.address_space
  depends_on          = [azurerm_resource_group.testrg]

}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]
  depends_on           = [azurerm_virtual_network.testvnet]

}
