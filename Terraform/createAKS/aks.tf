
resource "azurerm_kubernetes_cluster" "exampleaks" {
  name                = var.names.aksname
  location            = azurerm_resource_group.examplerg.location
  resource_group_name = azurerm_resource_group.examplerg.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}
