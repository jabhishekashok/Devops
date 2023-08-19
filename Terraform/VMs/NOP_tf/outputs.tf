output "vm-pub-ip" {
  value = "http://${azurerm_linux_virtual_machine.testvm2.public_ip_address}"
}
output "mysql-db-name" {
  value = azurerm_mysql_database.mysqldb.name
}
output "mysql-db-srvr-name" {
  value = azurerm_mysql_server.mysqldbsrvr.name
}
