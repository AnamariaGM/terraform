
# Resource block for creating DynamoDB tables
resource "aws_dynamodb_table" "dynamodb-table" {
  for_each = { for table_index, table in var.dynamodb_tables : table_index => table }

  name           = each.value.name          # Name of the DynamoDB table
  billing_mode   = "PAY_PER_REQUEST"        # Billing mode for DynamoDB (PAY_PER_REQUEST or PROVISIONED)
  hash_key       = each.value.primary_key   # Primary key for the DynamoDB table

  # Define attributes for the DynamoDB table
  attribute {
    name = "id"   # Name of the attribute
    type = "S"    # Type of the attribute (S for string, N for number, B for binary)
  }
}
