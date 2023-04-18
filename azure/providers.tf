terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.52.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.37.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}

provider "local" {
}

provider "helm" {
  kubernetes {
    # config_path = "~/.kube/config"
    host                   = azurerm_kubernetes_cluster.eso_aks.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.eso_aks.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.eso_aks.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.eso_aks.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubernetes" {
  # config_path = "~/.kube/config"
  host                   = azurerm_kubernetes_cluster.eso_aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.eso_aks.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.eso_aks.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.eso_aks.kube_config.0.cluster_ca_certificate)
}
