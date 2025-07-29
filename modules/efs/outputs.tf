file: /tomcat-ec2-efs-terraform/modules/efs/outputs.tf

output "file_system_id" {
  value = aws_efs_file_system.example.id
}

output "file_system_dns_name" {
  value = aws_efs_file_system.example.dns_name
}