provider "aws" {
  region = var.aws_region
}

module "efs" {
  source = "./modules/efs"
  file_system_name = var.efs_file_system_name
  throughput_mode = var.efs_throughput_mode
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.ec2_instance_type
  key_name = var.ec2_key_name
  efs_id = module.efs.file_system_id
  security_group_id = module.load_balancer.security_group_id
}

module "load_balancer" {
  source = "./modules/load-balancer"
  name = var.lb_name
  port = var.lb_port
  target_group_port = var.target_group_port
  health_check_path = var.health_check_path
  security_group_id = module.ec2.security_group_id
}

output "load_balancer_dns" {
  value = module.load_balancer.dns_name
}

output "ec2_instance_ids" {
  value = module.ec2.instance_ids
}

output "efs_file_system_id" {
  value = module.efs.file_system_id
}