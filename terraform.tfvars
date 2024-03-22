# AWS region where resources will be deployed
region = "eu-west-2"

# EC2 instance type for the application
instance_type = "t2.micro"

# IAM username for the project
iam_user_name = "project_user"

# IAM policy name for DynamoDB full access
policy_name = "AmazonDynamoDBFullAccess"

# Configuration details for the application services
configuration = {
  "Lighting" = {
    app_name        = "lighting",   # Name of the application
    no_of_instances = 1,            # Number of instances
    instance_type   = "t2.micro"    # Instance type
  },
  "Heating" = {
    app_name        = "heating",
    no_of_instances = 1,
    instance_type   = "t2.micro"
  },
  "Status" = {
    app_name        = "status",
    no_of_instances = 1,
    instance_type   = "t2.micro"
  }
}

# IAM instance profile name for the project
instance_profile_name = "project_instance_profile"

# SSH key pair name for EC2 instances
key_name = "first-ec2"

# DynamoDB tables configuration
dynamodb_tables = [
  { name = "lighting_table", primary_key = "id" },  # Name and primary key of the DynamoDB table for lighting
  { name = "heating", primary_key = "id" },         # Name and primary key of the DynamoDB table for heating
]

# Port for the application
port = 3000

# Names of services to be scaled by auto-scaling
services_names = [ "lighting", "heating", "status" ]

# Minimum number of instances for auto-scaling
min_instances = 1

# Maximum number of instances for auto-scaling
max_instances = 3

# Desired capacity of instances for auto-scaling
desired_capacity = 1
