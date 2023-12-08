
module "networking" {
  source = "./modules/networking"
  azs    = data.aws_availability_zones.available.names

}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}



module "dynamodb"{
  source = "./modules/dynamodb"
  dynamodb_tables = var.dynamodb_tables

}



module "app" {
  source                = "./modules/app"
  policy_name           = var.policy_name
  instance_profile_name = var.instance_profile_name
  iam_instance_profile  = var.instance_profile_name
  configuration         = var.configuration

  security_group_ids = module.security.security_group_ids
  public_subnets     = module.networking.public_subnets_ids
  iam_user_name      = var.iam_user_name
  key_name           = var.key_name

}
module "load_balancer"{
  source = "./modules/load_balancer"
  services = module.app.services
  port = var.port
  vpc_id = module.networking.vpc_id
  security_group_ids = module.security.security_group_ids
  public_subnets_ids = module.networking.public_subnets_ids
}


module "autoscaling" {
  source = "./modules/autoscaling"
  services_names = var.services_names
  min_instances = var.min_instances
  public_subnets_ids = module.networking.public_subnets_ids
  instances_ids = module.app.instances_ids
  max_instances = var.max_instances
  desired_instances = var.desired_capacity
  services = module.app.services
  target_group_arn = module.load_balancer.target_group_arns
  azs = data.aws_availability_zones.available.names

  
}