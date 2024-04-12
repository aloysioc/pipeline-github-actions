output "vm_aws_ip" {
  value = aws_instance.vm.public_ip
}