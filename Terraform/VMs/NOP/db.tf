resource "azurerm_mysql_server" "mysqldbsrvr" {
  name                = var.db_details.mysqldb_srvr_name
  location            = azurerm_resource_group.test-rg.location
  resource_group_name = azurerm_resource_group.test-rg.name

  administrator_login          = var.db_details.mysql_srvr_administrator_login
  administrator_login_password = var.db_details.mysql_srvr_administrator_pwd

  sku_name   = var.db_details.mysql_sku_name
  storage_mb = var.db_details.mysql_storage_mb
  version    = var.db_details.mysql_version

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "mysqldb" {
  name                = var.db_details.mysql_db_name
  resource_group_name = azurerm_resource_group.test-rg.name
  server_name         = azurerm_mysql_server.mysqldbsrvr.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}