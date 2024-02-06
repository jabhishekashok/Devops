data "azurerm_managed_disk" "existing" {
  name                = var.names.azdiskname
  resource_group_name = var.names.azdiskrg
}

output "mongo_disk_id" {
  value = data.azurerm_managed_disk.existing.id
}

data "azurerm_managed_disk" "existing-postgres" {
  name                = var.names.postgresazdiskname
  resource_group_name = var.names.postgresazdiskrg
}

output "postgres_disk_id" {
  value = data.azurerm_managed_disk.existing-postgres.id
}