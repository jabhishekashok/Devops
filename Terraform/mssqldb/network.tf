resource "azurerm_resource_group" "testrg" {
  name     = var.names.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "testvnet" {
  name                = var.names.virtual_network_name
  location            = azurerm_resource_group.testrg.location
  resource_group_name = azurerm_resource_group.testrg.name
  address_space       = var.address_space
  depends_on          = [azurerm_resource_group.testrg]
  tags = {
    Env       = var.names.env_name
    CreatedBy = "terraform"
  }

}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvnet.name
  address_prefixes     = [cidrsubnet(var.address_space[0], 8, count.index)]
  depends_on           = [azurerm_virtual_network.testvnet]

}
