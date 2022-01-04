# Create network security group and rule
resource "azurerm_network_security_group" "myterraformsg" {
  name                = "myNetworkSecurityGroup"
  location            = var.azurerm_location
  resource_group_name = local.resource_group_name

  security_rule {
    name                       = "SSh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    enviroment = "Terraform Demo"
  }
}

# # Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  name                = "myNIC"
  location            = var.azurerm_location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.myterraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }

  tags = {
    environment = "Terraform Demo"
  }
}

# Conect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = azurerm_network_security_group.myterraformsg.id
}