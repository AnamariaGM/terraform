region              = "eu-west-2"
# dynamodb_table_name = "db_table"
# count = 3
# partition_key_dynamodb = "id"
# sort_key_dynamodb      = "location"
instance_type          = "t2.micro"
iam_user_name          = "project_user"
policy_name            = "AmazonDynamoDBFullAccess"
configuration = {
  "Lighting" = {
    app_name        = "lighting",
    no_of_instances = 1,
    instance_type   = "t2.micro"
  },
  "Heating" = {
    app_name        = "heating",
    no_of_instances = 1,
    instance_type   = "t2.micro"
  },
  "Status"={
    app_name = "status",
    no_of_instances = 1,
    instance_type = "t2.micro"
  }
}
instance_profile_name = "project_instance_profile"
key_name              = "first-ec2"


dynamodb_tables= [
  { name = "lighting_table", primary_key = "id" },
  { name = "heating", primary_key = "id" },
]
port = 3000
