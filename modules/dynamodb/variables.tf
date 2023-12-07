# variable "dynamodb_table_name" {
#     type = string
#     description = "Name of the DynamoDb table"
  
# }

# variable "primary_key"{
#     type = string
# }

# variable "sort_key" {
#     type = string
  
# }

variable "dynamodb_tables" {
        type = list(object({
        name =string
        primary_key=string
    }))
    #  default = [
    # {
    #   name       = "first_table"
    #   primary_key = "id"
    # },
    # {
    #   name       = "second_table"
    #   primary_key = "id"
    # }]
  
}