data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}

data "azurerm_subnet" "sn2" {
  name                 = "sn2"
  virtual_network_name = azurerm_virtual_network.aks_nw.name
  resource_group_name  = azurerm_resource_group.network_rg.name
}

resource "random_id" "app_bytes" {
  # Generate a new id each time we switch to a new AMI id
  byte_length = 2
}
