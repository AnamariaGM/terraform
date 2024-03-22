# Data block to fetch information about an IAM user
data "aws_iam_user" "iam_user" {
  user_name = var.iam_user_name
}

# Data block to fetch information about an IAM policy
data "aws_iam_policy" "dynamodb_policy" {
  name = var.policy_name
}

# Local block to parse the assumed role policy and extract relevant information
locals {
  assume_role_policy = jsondecode(data.aws_iam_policy.dynamodb_policy.policy)

  actions_tuple               = local.assume_role_policy.Statement[0].Action
  instance_profile_name_match = regex("([a-zA-Z0-9+=,.@_-]+):[a-zA-Z*]+", local.actions_tuple[0])

  instance_profile_name_single = local.instance_profile_name_match[0]
}

# Data block to fetch information about an IAM instance profile
data "aws_iam_instance_profile" "app-instance_profile" {
  name = var.instance_profile_name
}

# Data block to fetch information about the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical owner ID
}
