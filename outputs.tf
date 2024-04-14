output "vm_aws_ip" {
  value = aws_instance.ce_instance.public_ip
}

output "vm_instance_id" {
  value = aws_instance.ce_instance.id
}