
module "networking" {
  source = "./modules/networking"
  azs    = data.aws_availability_zones.available.names

}

module "security" {
  source = "./modules/security"
  vpc_id = module.networking.vpc_id
}