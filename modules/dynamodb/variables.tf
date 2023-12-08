

variable "dynamodb_tables" {
        type = list(object({
        name =string
        primary_key=string
    }))
  
}