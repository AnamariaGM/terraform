variable "instances_ids" {
    type = list(string)
}
variable "services_names" {
    type = list(string)
  
}
variable "min_instances" {
    type=number
  
}
variable "desired_instances" {
    type = number
  
}
variable "max_instances" {
    type = number
  
}
variable "public_subnets_ids" {
    type = list(string)
  
}
variable "services" {
  type = map(object({
    name = string
    id = string
  }))
}
variable "target_group_arn" {
    type=list(string)
  
}
variable "azs" {
  
}