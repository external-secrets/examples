apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: azure-external-secret
  namespace: ${namespace}
spec:
  refreshInterval: 30s
  secretStoreRef:
    kind: SecretStore
    name: azure-secret-store

  target:
    name: secret-from-azurekv
    creationPolicy: Owner

  data:
    # explicit type and name of secret in the Azure KV
    - secretKey: secret-data
      remoteRef:
        key: secret/${secretReference}
