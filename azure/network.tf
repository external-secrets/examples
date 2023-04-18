

resource "azurerm_resource_group" "network_rg" {
  name     = "eso-network-rg"
  location =  var.azure_region
}

resource "azurerm_virtual_network" "aks_nw" {
  name                = "eso-demo-network"
  location            = azurerm_resource_group.network_rg.location
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = ["10.240.0.0/16"]

  subnet {
    name           = "sn1"
    address_prefix = "10.240.1.0/24"
  }

  subnet {
    name           = "sn2"
    address_prefix = "10.240.2.0/24"
  }

  tags = {
    environment = "eso-demo"
  }
}


###############
## Disabled the Private Endpoint beause the certificate 
## is not correct for the private endpoint address
###############

# resource "azurerm_private_dns_zone" "kv_zone" {
#   name                = "privatelink.vaultcore.azure.net"
#   resource_group_name = azurerm_resource_group.network_rg.name
# }

# resource "azurerm_private_endpoint" "pe_kv" {
#   name                = "pe-kv"
#   location            = azurerm_resource_group.network_rg.location
#   resource_group_name = azurerm_resource_group.network_rg.name
#   subnet_id           = data.azurerm_subnet.sn2.id

#   private_dns_zone_group {
#     name                 = "privatednszonegroup"
#     private_dns_zone_ids = [azurerm_private_dns_zone.kv_zone.id]
#   }

#   private_service_connection {
#     name                           = format("pse-2%s", "eso-keyvault")
#     private_connection_resource_id = azurerm_key_vault.eso-keyvault.id
#     is_manual_connection           = false
#     subresource_names              = ["Vault"]
#   }
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "kv_vn_link" {
#   name                  = "kv-vn-link"
#   resource_group_name   = azurerm_resource_group.network_rg.name
#   virtual_network_id    = azurerm_virtual_network.aks_nw.id
#   private_dns_zone_name = azurerm_private_dns_zone.kv_zone.name
#   registration_enabled  = true
# }
