output "azs" {
  value = data.aws_availability_zones.available.names

}
output "myipaddr" {
  value = module.security.ip_addres
  
}
output "public_ipv6" {
    value = module.security.public_ipv6
  
}