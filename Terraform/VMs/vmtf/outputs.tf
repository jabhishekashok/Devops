output "vm_ip_add" {
  value = azurerm_linux_virtual_machine.testvm.private_ip_address
}

output "database_endpoint" {
  value = azurerm_mssql_server.mssql-server.fully_qualified_domain_name
}

