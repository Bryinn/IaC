output "type" {
  value = "SQLAzure"
}
output "connection_string_value" {
  value = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}
output "db_name" {
  value = [ for i in azurerm_mssql_database.mssql_db: "${i.name}" ]
  description = "This is a touple with all database names. You will need to use a spesific instance."
}