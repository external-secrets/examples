

resource "azurerm_resource_group" "eso_aks_rg" {
  name     = "eso-aks-rg"
  location = var.azure_region
}

#get aks version
data "azurerm_kubernetes_service_versions" "aks_versions" {
  location = azurerm_resource_group.eso_aks_rg.location
}

resource "azurerm_kubernetes_cluster" "eso_aks" {
  name                = "eso-aks"
  location            = azurerm_resource_group.eso_aks_rg.location
  resource_group_name = azurerm_resource_group.eso_aks_rg.name
  dns_prefix          = "eso-aks"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.aks_versions.latest_version
  node_resource_group = "eso-aks-node-rg"

  default_node_pool {
    vnet_subnet_id = data.azurerm_subnet.sn2.id
    name           = "default"
    node_count     = 3
    vm_size        = "Standard_D2_v2"
  }

  network_profile {
    network_plugin     = "kubenet"
    load_balancer_sku  = "standard"
    service_cidr       = "10.0.0.0/16"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "eso-demo"
  }

}
