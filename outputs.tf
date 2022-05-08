output "vm_iazure_p" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm_aws_ip" {
  value = aws_instance.vm.public_ip
}