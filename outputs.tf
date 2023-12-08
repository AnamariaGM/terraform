output "azs" {
  value = data.aws_availability_zones.available.names

}

output "public_subnets" {
  value = module.networking.public_subnets_ids
}

output "iam_user_arn" {
  value = module.app.iam_user_arn
}

output "configuration_values" {
  value = var.configuration
}

output "security_group_ids" {
  value = module.security.security_group_ids

}
