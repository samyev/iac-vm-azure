output "resource_group_id" {
  value = azurerm_resource_group.myterraformgroup.id
}

output "tls_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}