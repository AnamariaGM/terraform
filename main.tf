# Defining networking module for managing VPC, subnets, and routing
module "networking" {
  source = "./modules/networking"   # Path to the networking module
  azs    = data.aws_availability_zones.available.names  # Availability zones to use for subnet placement
}

# Define security module for managing security groups and IAM roles/policies
module "security" {
  source = "./modules/security"  # Path to the security module
  vpc_id = module.networking.vpc_id  # VPC ID obtained from the networking module
}

# Define DynamoDB module for managing DynamoDB tables
module "dynamodb" {
  source = "./modules/dynamodb"  # Path to the DynamoDB module
  dynamodb_tables = var.dynamodb_tables  # List of DynamoDB table configurations
}

# Define application module for managing application instances and IAM roles
module "app" {
  source                = "./modules/app"  # Path to the application module
  policy_name           = var.policy_name  # Name of the IAM policy to attach to instances
  instance_profile_name = var.instance_profile_name  # Name of the IAM instance profile
  iam_instance_profile  = var.instance_profile_name  # IAM instance profile
  configuration         = var.configuration  # Configuration details for the application

  # Dependencies from other modules
  security_group_ids = module.security.security_group_ids  # Security group IDs from the security module
  public_subnets     = module.networking.public_subnets_ids  # Public subnet IDs from the networking module
  iam_user_name      = var.iam_user_name  # IAM user name
  key_name           = var.key_name  # SSH key name for accessing instances
}

# Define load balancer module for managing load balancer resources
module "load_balancer" {
  source = "./modules/load_balancer"  # Path to the load balancer module
  services = module.app.services  # Services configuration for load balancing
  port = var.port  # Port for load balancer
  vpc_id = module.networking.vpc_id  # VPC ID obtained from the networking module
  security_group_ids = module.security.security_group_ids  # Security group IDs from the security module
  public_subnets_ids = module.networking.public_subnets_ids  # Public subnet IDs from the networking module
}

# Define autoscaling module for managing auto-scaling of application instances
module "autoscaling" {
  source = "./modules/autoscaling"  # Path to the autoscaling module
  services_names = var.services_names  # Names of services to scale
  min_instances = var.min_instances  # Minimum number of instances
  public_subnets_ids = module.networking.public_subnets_ids  # Public subnet IDs from the networking module
  instances_ids = module.app.instances_ids  # Instance IDs managed by the application module
  max_instances = var.max_instances  # Maximum number of instances
  desired_instances = var.desired_capacity  # Desired capacity of instances
  services = module.app.services  # Services configuration
  target_group_arn = module.load_balancer.target_group_arns  # Target group ARNs from the load balancer module
  azs = data.aws_availability_zones.available.names  # Availability zones to use for scaling
}
