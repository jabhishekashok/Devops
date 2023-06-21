resource "azurerm_resource_group" "testrg" {
  name     = "test-rg"
  location = var.location
}

resource "azurerm_virtual_network" "testvnet" {
  name                = "testvnet"
  location            = var.location
  resource_group_name = "test-rg"
  address_space       = var.vnet-range
  depends_on          = [azurerm_resource_group.testrg]
}

