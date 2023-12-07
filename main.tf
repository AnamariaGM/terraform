
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
  # instance_type = var.configuration

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


