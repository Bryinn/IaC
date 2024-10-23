output "type" {
  value = "SQLAzure"
}
output "connection_string_value" {
  value = azurerm_mssql_server.example.fully_qualified_domain_name
}