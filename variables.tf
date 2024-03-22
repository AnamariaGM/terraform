# Defining variable for AWS region
variable "region" {
  type = string  # Data type of the variable (string in this case)
}

# Defining variable for EC2 instance type
variable "instance_type" {
  type = string  # Data type of the variable (string in this case)
}

# Defining variable for IAM username
variable "iam_user_name" {
  # No explicit data type defined, assumed to be string
}

# Defining variable for IAM policy name
variable "policy_name" {
  # No explicit data type defined, assumed to be string
}

# Defining variable for application configuration
variable "configuration" {
  type = map(object({              # Data type is a map of objects
    app_name        = string       # Name of the application (string)
    no_of_instances = number       # Number of instances (number)
    instance_type   = string       # Instance type (string)
  }))
}

# Defining variable for IAM instance profile name
variable "instance_profile_name" {
  type = string  # Data type of the variable (string in this case)
}

# Defining variable for SSH key pair name
variable "key_name" {
  # No explicit data type defined, assumed to be string
}

# Defining variable for DynamoDB tables configuration
variable "dynamodb_tables" {
  type = list(object({            # Data type is a list of objects
    name        = string          # Name of the DynamoDB table (string)
    primary_key = string          # Primary key of the DynamoDB table (string)
  }))
}

# Defining variable for port number
variable "port" {
  type = number  # Data type of the variable (number in this case)
}

# Defining variable for names of services
variable "services_names" {
  type = list(string)  # Data type is a list of strings
}

# Defining variable for minimum number of instances
variable "min_instances" {
  type = number  # Data type of the variable (number in this case)
}

# Defining variable for maximum number of instances
variable "max_instances" {
  type = number  # Data type of the variable (number in this case)
}

# Defining variable for desired capacity of instances
variable "desired_capacity" {
  type = number  # Data type of the variable (number in this case)
}
