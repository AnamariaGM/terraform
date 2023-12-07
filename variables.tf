variable "region" {
  type = string

}

# variable "dynamodb_table_name" {
#   type = string

# }

# variable "partition_key_dynamodb" {
#   type = string

# }

# variable "sort_key_dynamodb" {
#   type = string

# }
variable "instance_type" {
  type = string

}
variable "iam_user_name" {

}
variable "policy_name" {

}

variable "configuration" {
  type = map(object({
    app_name        = string
    no_of_instances = number
    instance_type   = string
  }))


}
variable "instance_profile_name" {
  type = string

}

variable "key_name" {

}
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