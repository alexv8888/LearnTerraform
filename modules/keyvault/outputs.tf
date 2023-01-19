output "created_password" {
  value = azurerm_key_vault_secret.password.value
}