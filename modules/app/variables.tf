variable "public_subnets" {
}

variable "security_group_ids" {
  type = list(string)
}
variable "iam_instance_profile" {
}

variable "iam_user_name" {
}

variable "policy_name" {
}

variable "configuration" {
  type = map(object({
    app_name        = string
    no_of_instances = number
    instance_type   = string
  }))

}
variable "instance_profile_name" {
  type = string

}
variable "key_name" {
  type = string

}