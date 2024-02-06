# resource "azurerm_resource_group" "demo" {
#   name     = var.names.rgname
#   location = var.rglocation
# }

data "azurerm_resource_group" "demo" {
  name = var.names.rgname
}

# resource "azurerm_network_security_group" "aksnsg" {
#   name                = "aksnsg"
#   resource_group_name = data.azurerm_resource_group.demo.name
#   location            = data.azurerm_resource_group.demo.location
# }
# resource "azurerm_network_security_rule" "aksnsg_rule" {
#   name                        = "HTTPblock"
#   resource_group_name         = data.azurerm_resource_group.demo.name
#   network_security_group_name = azurerm_network_security_group.aksnsg.name
#   priority                    = 300
#   direction                   = "Inbound"
#   access                      = "Deny"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
# }

# resource "azurerm_subnet_network_security_group_association" "ntiernsg_assc" {
#   subnet_id                 = azurerm_subnet.gwSubnet.id
#   network_security_group_id = azurerm_network_security_group.aksnsg.id
# }

resource "azurerm_virtual_network" "demo" {
  name                = "${var.prefix}-network"
  location            = data.azurerm_resource_group.demo.location
  resource_group_name = data.azurerm_resource_group.demo.name
  address_space       = ["10.0.0.0/8"]

  depends_on = [data.azurerm_resource_group.demo]
}

resource "azurerm_subnet" "clusterSubnet" {
  name                 = "${var.prefix}-Clustersubnet"
  virtual_network_name = azurerm_virtual_network.demo.name
  resource_group_name  = data.azurerm_resource_group.demo.name
  address_prefixes     = ["10.240.0.0/16"]

  depends_on = [data.azurerm_resource_group.demo, azurerm_virtual_network.demo]
}

resource "azurerm_subnet" "gwSubnet" {
  name                 = "${var.prefix}-gwSubnet"
  virtual_network_name = azurerm_virtual_network.demo.name
  resource_group_name  = data.azurerm_resource_group.demo.name
  address_prefixes     = ["10.241.0.0/16"]

  depends_on = [data.azurerm_resource_group.demo, azurerm_virtual_network.demo]
}

# resource "azurerm_public_ip" "gwPublicIp" {
#   name                = "${var.prefix}-gwPublicIP"
#   resource_group_name = azurerm_resource_group.demo.name
#   location            = azurerm_resource_group.demo.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
#   sku_tier            = "Regional"
# }

# locals {
#   backend_address_pool_name      = "${azurerm_virtual_network.demo.name}-beap"
#   frontend_port_name             = "${azurerm_virtual_network.demo.name}-feport"
#   frontend_ip_configuration_name = "${azurerm_virtual_network.demo.name}-feip"
#   http_setting_name              = "${azurerm_virtual_network.demo.name}-be-htst"
#   listener_name                  = "${azurerm_virtual_network.demo.name}-httplstn"
#   request_routing_rule_name      = "${azurerm_virtual_network.demo.name}-rqrt"
#   redirect_configuration_name    = "${azurerm_virtual_network.demo.name}-rdrcfg"
# }

