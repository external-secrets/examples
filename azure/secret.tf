
# Create a Secret in Azure Key Vault
resource "azurerm_key_vault_secret" "demo_secret" {
  name         = "eso-demo-secret"
  value        = "Hello Kubecon EU 2023 - This is a Secret from Azure Key Vault !"
  key_vault_id = azurerm_key_vault.eso-keyvault.id

  depends_on = [
    azurerm_key_vault.eso-keyvault,
    azurerm_key_vault_access_policy.sp_access_policy,
    azurerm_key_vault_access_policy.user_access_policy,
    time_sleep.wait, # Wait for the Key Vault to be ready
  ]
}
