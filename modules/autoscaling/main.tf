# Resource block for creating custom AMIs from instances
resource "aws_ami_from_instance" "custom_amis" {
  count            = length(var.instances_ids)
  name             = "custom-ami-${var.services_names[count.index]}"
  source_instance_id = element(var.instances_ids, count.index)
}

# Resource block for creating launch templates for autoscaling
resource "aws_launch_template" "launch_template" {
  count = length(var.services_names)
  name     = "launch-template-${var.services_names[count.index]}"

  network_interfaces {
    associate_public_ip_address = true
  }

  image_id          = aws_ami_from_instance.custom_amis[count.index].id
  instance_type     = "t2.micro"
  key_name          = "first-ec2"  
  disable_api_stop = true
  disable_api_termination = true  
  monitoring {
    enabled = true
  }
  placement {
    availability_zone = var.azs[0]
  }
}

# Resource block for creating autoscaling groups
resource "aws_autoscaling_group" "project_asg" {
  count = length(var.services_names)
  name = "ag-${var.services_names[count.index]}"
  desired_capacity     = var.desired_instances
  max_size             = var.max_instances
  min_size             = var.min_instances
  launch_template {
    id      = aws_launch_template.launch_template[count.index].id
    version = aws_launch_template.launch_template[count.index].latest_version
  }
  vpc_zone_identifier  = var.public_subnets_ids
  health_check_type    = "EC2"
  health_check_grace_period = 300  
  force_delete = true
}

# Resource block for attaching autoscaling groups to load balancers
resource "aws_autoscaling_attachment" "lb_attachment" {
  count = length(var.services_names)

  autoscaling_group_name = aws_autoscaling_group.project_asg[count.index].name
  lb_target_group_arn   = var.target_group_arn[count.index]
}
