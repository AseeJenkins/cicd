variable "resource" {
    type = object({
      name = string
      location = string
    })
    default = {
      location = "eastus"
      name = "kube_rg"
    }
}
variable "vnet_info" {
    type = object({
      name = string
      address_space = list(string)
    })
    default = {
      name = "kube_vnet"
      address_space = ["10.1.0.0/16"]
    }
}
variable "subnet_info" {
  type = object({
    name = string
    address_prefixes = list(string)
  })
  default = {
    name = "internal"
    address_prefixes = ["10.1.0.0/24"]
  }
}
variable "cluster_info" {
  type = object({
    name = string
    dns_prefix = string 
  })
  default = {
    name = "kube_cluster"
    dns_prefix = "kubedns"
  }
}
variable "node_info" {
  type = object({
    name = string
    vm_size = string
    node_count = number
  })
  default = {
    name = "system"
    vm_size = "Standard_B2ms"
    node_count = 2
  }
}
variable "acr_info" {
  type = object({
    name = string
    sku = string
  })
  default = {
    name = "aseerwadham"
    sku = "Basic"
  }
}