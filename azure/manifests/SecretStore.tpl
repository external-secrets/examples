apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: azure-secret-store
  namespace: ${namespace}
spec:
  provider:
    # provider type: azure keyvault
    azurekv:
      tenantId: ${tenantId}
      # URL of your vault instance,
      vaultUrl: ${vaultUrl}
      authSecretRef:
        # points to the secret that contains
        # the azure service principal credentials
        clientId:
          name: azure-secret-sp
          key: ClientID
        clientSecret:
          name: azure-secret-sp
          key: ClientSecret
