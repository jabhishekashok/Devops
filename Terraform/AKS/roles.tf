# resource "azurerm_role_assignment" "aks_id_contributor_storage" {
#   scope                = data.azurerm_managed_disk.existing.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_kubernetes_cluster.demo.identity[0].principal_id
#   depends_on           = [azurerm_application_gateway.network]
# }

# data "azurerm_subscription" "primary" {
# }

# data "azurerm_client_config" "example" {
# }


### Mongo DB Disk access

resource "azurerm_role_definition" "example" {
  name               = "custom-storage-role-definition-mongo"
  scope              = data.azurerm_managed_disk.existing.id

  permissions {
    actions     = ["Microsoft.Compute/disks/read"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_managed_disk.existing.id,
  ]
}

resource "azurerm_role_assignment" "aks_id_contributor_storage" {
  scope              = data.azurerm_managed_disk.existing.id
  role_definition_id = azurerm_role_definition.example.role_definition_resource_id
  principal_id       = azurerm_kubernetes_cluster.demo.identity[0].principal_id
}

### Postgres Keycloak Disk access

resource "azurerm_role_definition" "existing-postgres" {
  name               = "custom-storage-role-definition-postgres"
  scope              = data.azurerm_managed_disk.existing-postgres.id

  permissions {
    actions     = ["Microsoft.Compute/disks/read"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_managed_disk.existing-postgres.id,
  ]
}

resource "azurerm_role_assignment" "aks_id_contributor_storage-postgres" {
  scope              = data.azurerm_managed_disk.existing-postgres.id
  role_definition_id = azurerm_role_definition.existing-postgres.role_definition_resource_id
  principal_id       = azurerm_kubernetes_cluster.demo.identity[0].principal_id
}


resource "azurerm_role_assignment" "aks_id_network_contributor_subnet" {
  scope                = azurerm_subnet.clusterSubnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.demo.identity[0].principal_id

  depends_on = [azurerm_virtual_network.demo]
}

# resource "azurerm_role_assignment" "aks_id_contributor_agw" {
#   scope                = azurerm_application_gateway.network.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_kubernetes_cluster.demo.identity[0].principal_id
#   depends_on           = [azurerm_application_gateway.network]
# }

# resource "azurerm_role_assignment" "aks_ingressid_contributor_on_agw" {
#   scope                            = azurerm_application_gateway.network.id
#   role_definition_name             = "Contributor"
#   principal_id                     = azurerm_kubernetes_cluster.demo.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
#   depends_on                       = [azurerm_application_gateway.network]
#   skip_service_principal_aad_check = true
# }

# resource "azurerm_role_assignment" "aks_ingressid_contributor_on_uami" {
#   scope                            = azurerm_user_assigned_identity.identity_uami.id
#   role_definition_name             = "Contributor"
#   principal_id                     = azurerm_kubernetes_cluster.demo.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
#   #depends_on                       = [azurerm_application_gateway.network]
#   skip_service_principal_aad_check = true
# }

# resource "azurerm_role_assignment" "uami_contributor_on_agw" {
#   scope                            = azurerm_application_gateway.network.id
#   role_definition_name             = "Contributor"
#   principal_id                     = azurerm_user_assigned_identity.identity_uami.principal_id
#   depends_on                       = [azurerm_application_gateway.network]
#   skip_service_principal_aad_check = true
# }