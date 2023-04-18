
# Create a manifest for the Secret Store
resource "local_file" "SecretStore" {
  content = templatefile("manifests/SecretStore.tpl", {
    "vaultUrl"  = azurerm_key_vault.eso-keyvault.vault_uri,
    "tenantId"  = data.azurerm_subscription.primary.tenant_id,
    "namespace" = var.demo_namespace,
  })
  filename = "./eso_SecretStore.yaml"
}

# Create a manifest for the External Secret
resource "local_file" "ExternalSecret" {
  content = templatefile("manifests/ExternalSecret.tpl", {
    "namespace"       = var.demo_namespace,
    "secretReference" = azurerm_key_vault_secret.demo_secret.name
  })

  filename = "./eso_ExternalSecret.yaml"
}


