resource "aws_efs_file_system" "this" {
  creation_token = var.file_system_name
  performance_mode = var.performance_mode
  throughput_mode = var.throughput_mode

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_efs_mount_target" "this" {
  count          = length(var.subnet_ids)
  file_system_id = aws_efs_file_system.this.id
  subnet_id      = var.subnet_ids[count.index]
  security_groups = var.security_groups
}

output "file_system_id" {
  value = aws_efs_file_system.this.id
}

output "dns_name" {
  value = aws_efs_file_system.this.dns_name
}