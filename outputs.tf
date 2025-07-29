output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}

output "ec2_public_ips" {
  value = module.ec2.public_ips
}

output "efs_file_system_id" {
  value = module.efs.file_system_id
}

output "efs_dns_name" {
  value = module.efs.dns_name
}

output "load_balancer_dns_name" {
  value = module.load_balancer.dns_name
}