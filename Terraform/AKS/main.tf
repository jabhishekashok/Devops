resource "azurerm_kubernetes_cluster" "demo" {
  location            = data.azurerm_resource_group.demo.location
  name                = var.names.aksname
  resource_group_name = data.azurerm_resource_group.demo.name
  dns_prefix          = var.k8sdetails.dns_prefix

  default_node_pool {
    name                = var.k8sdetails.nodepool_name
    vm_size             = var.k8sdetails.vm_size
    node_count          = var.k8sdetails.agent_count
    vnet_subnet_id      = azurerm_subnet.clusterSubnet.id
    enable_auto_scaling = true
    max_count           = 10
    min_count           = 2
    os_disk_size_gb     = 30
    type                = "VirtualMachineScaleSets"

  }

  linux_profile {
    admin_username = var.k8sdetails.admin_username

    ssh_key {
      key_data = file(var.k8sdetails.ssh_public_key)
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    # service_cidr       = "10.100.0.0/16"
    # dns_service_ip     = "10.100.0.10"
    #docker_bridge_cidr = "172.17.0.1/16"
  }

  identity {
    type = "SystemAssigned"
  }

  # ingress_application_gateway{
  #   #gateway_id = azurerm_application_gateway.network.id
  #   subnet_id = azurerm_subnet.gwSubnet.id
  # }

  # addon_profile {
  #   # oms_agent {
  #   #   enabled                    = var.addons.oms_agent
  #   #   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
  #   # }

  #   ingress_application_gateway {
  #     enabled   = true
  #     gateway_name = "${var.prefix}-appgw"
  #     subnet_id = azurerm_subnet.gwSubnet.id
  #   }
  #     http_application_routing {
  #     enabled = "false"
  #   }

  # }
  # ingress_application_gateway{
  #   #gateway_id = azurerm_application_gateway.network.id
  #   subnet_id = azurerm_subnet.gwSubnet.id
  # }

  # addon_profile {
  #   # oms_agent {
  #   #   enabled                    = var.addons.oms_agent
  #   #   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
  #   # }

  #   ingress_application_gateway {
  #     enabled   = true
  #     gateway_name = "${var.prefix}-appgw"
  #     subnet_id = azurerm_subnet.gwSubnet.id
  #   }
  #     http_application_routing {
  #     enabled = "false"
  #   }

  # }
  #   service_principal {
  #     client_id     = var.aks_service_principal_app_id
  #     client_secret = var.aks_service_principal_client_secret
  #   }

  tags = {
    Environment = "Development"
  }

  depends_on = [data.azurerm_resource_group.demo, azurerm_virtual_network.demo, azurerm_subnet.clusterSubnet]

}

# data "azurerm_container_registry" "testacr" {
#   name                = var.names.acrname
#   resource_group_name = data.data.azurerm_resource_group.demo.name
#   resource_group_name = data.data.azurerm_resource_group.demo.name

#   depends_on = [data.data.azurerm_resource_group.demo]
#   depends_on = [data.data.azurerm_resource_group.demo]
# }


resource "azurerm_container_registry" "testacr" {
  name                = var.names.acrname
  resource_group_name = data.azurerm_resource_group.demo.name
  location            = data.azurerm_resource_group.demo.location
  sku                 = "Standard"
  admin_enabled       = true

  tags = {
    environment = "Development"
  }
  depends_on = [data.azurerm_resource_group.demo, azurerm_kubernetes_cluster.demo]
}


# add the role to the identity the kubernetes cluster was assigned

resource "azurerm_role_assignment" "aks_to_acr" {
  scope                = azurerm_container_registry.testacr.id #azurerm_container_registry.testacr.id #
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.demo.kubelet_identity[0].object_id

  depends_on = [data.azurerm_resource_group.demo, azurerm_kubernetes_cluster.demo, azurerm_container_registry.testacr]
}


resource "azurerm_role_assignment" "node_infrastructure_update_scale_set" {
  principal_id         = azurerm_kubernetes_cluster.demo.kubelet_identity[0].object_id
  scope                = data.azurerm_resource_group.demo.id
  role_definition_name = "Virtual Machine Contributor"
  depends_on = [
    azurerm_kubernetes_cluster.demo
  ]
}
