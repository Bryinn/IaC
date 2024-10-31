output "type" {
  value = "SQLAzure"
}
output "connection_string_value" {
  value = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}