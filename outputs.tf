# Output the names of available availability zones
output "azs" {
  value = data.aws_availability_zones.available.names
}

# Output the IDs of public subnets
output "public_subnets" {
  value = module.networking.public_subnets_ids
}

# Output the ARN of the IAM user
output "iam_user_arn" {
  value = module.app.iam_user_arn
}

# Output the configuration values
output "configuration_values" {
  value = var.configuration
}

# Output the IDs of security groups
output "security_group_ids" {
  value = module.security.security_group_ids
}

