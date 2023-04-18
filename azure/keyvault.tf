// Create a Resource Group
resource "azurerm_resource_group" "keyvault_rg" {
  name     = "eso-keyvault-rg"
  location = var.azure_region
}

// Create a Key Vault
resource "azurerm_key_vault" "eso-keyvault" {
  name                        = format("%s-%s", "eso-demo-keyvault", random_id.app_bytes.hex)
  location                    = azurerm_resource_group.keyvault_rg.location
  resource_group_name         = azurerm_resource_group.keyvault_rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  enabled_for_disk_encryption = false

  sku_name = "standard"

  depends_on = [
    azuread_service_principal.eso_sp,
    data.azurerm_client_config.current
  ]
}

# Grant access to the kv 
resource "azurerm_key_vault_access_policy" "sp_access_policy" {
  key_vault_id = azurerm_key_vault.eso-keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azuread_service_principal.eso_sp.id

  key_permissions = [
    "Get", "List",
  ]

  secret_permissions = [
    "Get", "List",
  ]

  certificate_permissions = []
  storage_permissions     = []

  depends_on = [
    azuread_service_principal.eso_sp,
    azurerm_key_vault.eso-keyvault,
    data.azurerm_client_config.current
  ]
}

# grant current user access 
resource "azurerm_key_vault_access_policy" "user_access_policy" {
  key_vault_id = azurerm_key_vault.eso-keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt",
    "Get", "Import", "List", "Purge", "Recover", "Restore",
    "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]

  secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge",
    "Recover", "Restore", "Set",
  ]

  storage_permissions = [
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS",
    "List", "ListSAS", "Purge", "Recover", "RegenerateKey",
    "Restore", "Set", "SetSAS", "Update",
  ]

  certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers",
    "Get", "GetIssuers", "Import", "List", "ListIssuers",
    "ManageContacts", "ManageIssuers", "Purge", "Recover",
    "Restore", "SetIssuers", "Update",
  ]

  depends_on = [
    azuread_service_principal.eso_sp,
    azurerm_key_vault.eso-keyvault,
    data.azurerm_client_config.current
  ]
}

# wait for 3 mins
resource "time_sleep" "wait" {
  depends_on = [
    azurerm_key_vault.eso-keyvault,
    azurerm_key_vault_access_policy.sp_access_policy,
    azurerm_key_vault_access_policy.user_access_policy
  ]
  create_duration = "3m"
}

output "keyvault_name" {
  value = azurerm_key_vault.eso-keyvault.name
}
