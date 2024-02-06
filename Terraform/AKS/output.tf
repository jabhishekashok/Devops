output "resource_group_name" {
  value = data.azurerm_resource_group.demo.id
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.demo.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.demo.kube_config_raw
  sensitive = true
}

output "acr_name" {
  value = azurerm_container_registry.testacr.login_server
}

output "aks_principal_id" {
  value = azurerm_kubernetes_cluster.demo.identity[0].principal_id
}

output "kubelet_id" {
  value = azurerm_kubernetes_cluster.demo.kubelet_identity[0].object_id
}

output "created_vnet_id" {
  value = azurerm_subnet.clusterSubnet.id
}

output "AKS_node_RG" {
  value = azurerm_kubernetes_cluster.demo.node_resource_group
}

# output "Public_IP" {
#   value = azurerm_public_ip.gwPublicIp.ip_address
# }

# output "client_key" {
#   value     = azurerm_kubernetes_cluster.demo.kube_config[0].client_key
#   sensitive = true
# }

# output "cluster_ca_certificate" {
#   value     = azurerm_kubernetes_cluster.demo.kube_config[0].cluster_ca_certificate
#   sensitive = true
# }

# output "cluster_password" {
#   value     = azurerm_kubernetes_cluster.demo.kube_config[0].password
#   sensitive = true
# }

# output "cluster_username" {
#   value     = azurerm_kubernetes_cluster.demo.kube_config[0].username
#   sensitive = true
# }

# output "host" {
#   value     = azurerm_kubernetes_cluster.demo.kube_config[0].host
#   sensitive = true
# }