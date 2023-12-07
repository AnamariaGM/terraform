# output "dynamodb_arn" {
#     value = aws_dynamodb_table.dynamodb-table.arn
  
# }
output "created_dynamodb_tables" {
  value = aws_dynamodb_table.dynamodb-table
}
