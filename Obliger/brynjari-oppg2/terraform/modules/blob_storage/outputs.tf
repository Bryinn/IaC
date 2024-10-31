output "access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}
output "account_name" {
  value = azurerm_storage_account.sa.name
}
output "share_name" {
  value = azurerm_storage_blob.blob.name
}
output "type" {
  value = azurerm_storage_blob.blob.type
}
