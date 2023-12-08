region              = "eu-west-2"
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

services_names = [ "lighting","heating","status" ]
 min_instances = 1
 max_instances = 3
 desired_capacity = 1