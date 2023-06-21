resource "azurerm_resource_group" "testrg" {
  name     = "test-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "testvnet" {
    name        = "testvnet"
    location    = "eastus"
    resource_group_name = "test-rg"
    address_space = ["10.0.0.0/16"]
    depends_on = [azurerm_resource_group.testrg]
}
