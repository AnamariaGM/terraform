locals {
  # Mapping of application names to subnet IDs
  subnet_mapping = {
    "Lighting" = var.public_subnets[0]
    "Heating"  = var.public_subnets[1]
    "Status"   = var.public_subnets[2]
  }

  # Configuration for each server instance
  serverconfig = flatten([
    for config_name, server in var.configuration : [
      for i in range(1, server["no_of_instances"] + 1) : {
        instance_name         = "${server["app_name"]}"
        instance_type         = server["instance_type"]
        instance_profile_name = local.instance_profile_name_single
        subnet_id             = local.subnet_mapping[config_name]
      }
    ]
  ])
}

# Resource block for creating EC2 instances
resource "aws_instance" "app_server" {
  for_each                   = { for server in local.serverconfig : server.instance_name => server }
  ami                        = data.aws_ami.ubuntu.id
  instance_type              = each.value.instance_type
  subnet_id                  = each.value.subnet_id
  tags = {
    Name = "${each.value.instance_name}"
  }
  vpc_security_group_ids     = var.security_group_ids
  associate_public_ip_address = true
  iam_instance_profile       = data.aws_iam_instance_profile.app-instance_profile.name
  key_name                   = var.key_name
}
