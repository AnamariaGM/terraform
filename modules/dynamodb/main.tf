
resource "aws_dynamodb_table" "dynamodb-table" {
  for_each = { for table_index, table in var.dynamodb_tables : table_index => table }

  name           = each.value.name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = each.value.primary_key

  attribute {
    name = "id"
    type = "S"
  }
}