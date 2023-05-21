resource "azurerm_resource_group" "kuberg" {
  name     = var.resource.name
  location = var.resource.location
}

resource "azurerm_virtual_network" "kubevnet" {
  name                = var.vnet_info.name
  location            = azurerm_resource_group.kuberg.location
  resource_group_name = azurerm_resource_group.kuberg.name
  address_space       = var.vnet_info.address_space
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_info.name
  virtual_network_name = azurerm_virtual_network.kubevnet.name
  resource_group_name  = azurerm_resource_group.kuberg.name
  address_prefixes     = var.subnet_info.address_prefixes
}

resource "azurerm_kubernetes_cluster" "kubecluster" {
  name                = var.cluster_info.name
  location            = azurerm_resource_group.kuberg.location
  resource_group_name = azurerm_resource_group.kuberg.name
  dns_prefix          = var.cluster_info.dns_prefix

  default_node_pool {
    name           = var.node_info.name
    node_count     = var.node_info.node_count
    vm_size        = var.node_info.vm_size
    vnet_subnet_id = azurerm_subnet.internal.id
  }

  identity {
    type = "SystemAssigned"
  }
}

# resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
#   name                  = "aseenodes"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.kubecluster.id
#   vm_size               = "Standard_B2ms"
#   node_count            = 2
#   vnet_subnet_id        = azurerm_subnet.internal.id
# }