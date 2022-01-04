# Create a resouce group 
resource "azurerm_resource_group" "myterraformgroup" {
  name     = local.resource_group_name
  location = var.azurerm_location

  tags = {
    enviroment = "Terraform Demo"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.azurerm_location
  resource_group_name = local.resource_group_name

  tags = {
    enviroment = "Terraform Demo"
  }
}

# Create a subnet
resource "azurerm_subnet" "myterraformsubnet" {
  name                 = "mySubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "myPublicIP"
  location            = var.azurerm_location
  resource_group_name = local.resource_group_name
  allocation_method   = "Dynamic"

  tags = {
    enviroment = "Terraform Demo"
  }
}
