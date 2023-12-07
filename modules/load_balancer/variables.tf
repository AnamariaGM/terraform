variable "services" {
  type = map(object({
    name = string
    id = string
  }))
}
variable "vpc_id" {
  
}
# variable "instances_ids" {
 
# }
variable "port"{

}

variable "public_subnets_ids" {
  
}
variable "security_group_ids" {
  
}