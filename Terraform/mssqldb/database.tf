resource "azurerm_mssql_server" "mssql-server" {
  name                         = var.names.mssql_server_name
  resource_group_name          = azurerm_resource_group.testrg.name
  location                     = azurerm_resource_group.testrg.location
  version                      = "12.0"
  administrator_login          = "devops"
  administrator_login_password = "WelcometoJungle@123"
}

resource "azurerm_mssql_database" "mssql-database" {
  name        = var.names.mssql_database_name
  server_id   = azurerm_mssql_server.mssql-server.id
  max_size_gb = 2
  sku_name    = "Basic"
}