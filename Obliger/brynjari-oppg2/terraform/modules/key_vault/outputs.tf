output "secrets" {
  value =  [ for i in azurerm_key_vault_secret.secrets: "${i.value}" ]
}
