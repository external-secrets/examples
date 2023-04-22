

// Installs the ESO chart to the AKS cluster
resource "helm_release" "eso" {
  name             = "eso-operator"
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = var.chart_version
  namespace        = "external-secrets"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "concurrent"
    value = "2"
  }

  depends_on = [
    azurerm_kubernetes_cluster.eso_aks,
  ]
}

// Create a Namespace for the Demo
resource "kubernetes_namespace" "demo_namespace" {
  metadata {
    name = var.demo_namespace
  }
}

// Create a Secret for ESO to Access the Key Vault
resource "kubernetes_secret" "creds" {
  metadata {
    name      = "azure-secret-sp"
    namespace = var.demo_namespace
  }

  data = {
    ClientID     = azuread_application.eso_app.application_id
    ClientSecret = azuread_service_principal_password.auth.value
  }

  depends_on = [
    kubernetes_namespace.demo_namespace,
    azuread_service_principal_password.auth,
    azuread_service_principal.eso_sp,
    helm_release.eso,
  ]
}
