locals {
  subnet_mapping = {
    "Lighting" = var.public_subnets[0].id,
    "Heating"  = var.public_subnets[1].id, 
    "Status" =var.public_subnets[2].id 
  }

  serverconfig = flatten([
    for config_name, server in var.configuration : [
      for i in range(1, server["no_of_instances"] + 1) : {
        instance_name          = "${server["app_name"]}-${i}"
        instance_type          = server["instance_type"]
        instance_profile_name  = local.instance_profile_name_single
        subnet_id              = local.subnet_mapping[config_name]
      }
    ]
  ])
}




resource "aws_instance" "app_server" {
  for_each      = { for server in local.serverconfig : server.instance_name => server }
  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  tags = {
    Name = "${each.value.instance_name}"
  }
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = true
  iam_instance_profile        = data.aws_iam_instance_profile.app-instance_profile.name
  key_name                    = var.key_name
  # user_data                   = <<-EOF
  #             #!/bin/bash
  #             sudo apt-get update
  #             sudo apt-get install -y aws-cli
  #             EOF
  # provisioner "remote-exec" {
  #   inline = [
  #     "terraform init",
  #     "terraform apply -var 'dynamodb_table_name=${each.value.instance_name}_table' -auto-approve",
  #   ]
  # }
  # connection {
  #   type        = "ssh"
  #   user        = "ubuntu"
  #   private_key = file("/home/anamaria/Downloads/first-ec2.pem")
  #   host        = self.public_ip
  # }
}

