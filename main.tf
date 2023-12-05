
module "networking" {
  source = "./modules/networking"
  azs    = data.aws_availability_zones.available.names

}