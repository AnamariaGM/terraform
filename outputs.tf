output "azs" {
  value = data.aws_availability_zones.available.names

}
# output "myipaddr" {
#   value = module.security.ip_addres

# }
# output "public_ipv6" {
#   value = module.security.public_ipv6

# }
output "public_subnets" {
  value = module.networking.public_subnets_ids
}

output "iam_user_arn" {
  value = module.app.iam_user_arn
}

# output "dynamodb_policy_arn" {
#   value = module.app.dynamodb_policy_arn
# }
output "configuration_values" {
  value = var.configuration
}

output "security_group_ids" {
  value = module.security.security_group_ids

}
