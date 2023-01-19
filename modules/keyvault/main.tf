data "azurerm_client_config" "current" {

}

resource "azurerm_key_vault" "kv" {

  name                = "LearnTerraformKV-${var.environment}"
  resource_group_name = var.rgname
  tenant_id           = data.azurerm_client_config.current.tenant_id
  location            = var.location
  sku_name            = "standard"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "Set", "Delete", "Purge", "List"
    ]
  }
}

resource "random_password" "vm_password" {
  length  = 12
  special = true
}

resource "azurerm_key_vault_secret" "password" {
  key_vault_id = azurerm_key_vault.kv.id
  name         = "ServerPW-${var.environment}"
  value        = random_password.vm_password.result
}
