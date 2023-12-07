# resource "aws_dynamodb_table" "dynamodb-table" {
#   name           = var.dynamodb_table_name
#   billing_mode   = "PAY_PER_REQUEST"
# #   read_capacity  = 10
# #   write_capacity = 10
#   hash_key       = var.primary_key
#   # range_key      = var.sort_key

#   attribute {
#     name = "id"
#     type = "S"
#   }

#   # attribute {
#   #   name = "status"
#   #   type = "S"
#   # }
#   # attribute {
#   #   name = "location"
#   #   type = "S"
#   # }
# }

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