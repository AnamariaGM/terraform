# output "instance_id" {
#   value = aws_instance.app_server[each.key]
# }
output "iam_instance_profile" {
  value = local.instance_profile_name_single


}
output "iam_user_arn" {
  value = data.aws_iam_user.iam_user.arn
}

output "dynamodb_policy_arn" {
  value = data.aws_iam_policy.dynamodb_policy.arn
}
