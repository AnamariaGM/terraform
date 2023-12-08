# Infrastructure as Code with Terraform

This repository contains Terraform configurations for setting up a scalable and secure infrastructure on AWS.

## Overview

The Terraform configuration in this repository is designed to dynamically create and manage AWS infrastructure components using modularization and loops. The infrastructure consists of several modules that handle networking, security, application deployment, load balancing, and auto-scaling.

## Modules

### 1. Networking Module

This module sets up the foundational networking components, including a Virtual Private Cloud (VPC) and multiple subnets across different availability zones.

#### Variables

- `azs`: List of availability zones.

#### Outputs

- `vpc_id`: The ID of the created VPC.

### 2. Security Module

The security module configures security-related resources, such as security groups and associated rules. It ensures that the communication between different components adheres to security best practices.

#### Variables

- `vpc_id`: The ID of the VPC to associate security groups with.

#### Outputs

- `security_group_ids`: List of security group IDs.

### 3. DynamoDB Module

This module is responsible for creating DynamoDB tables based on the provided configuration. It supports the dynamic creation of multiple tables, each with its own set of properties.

#### Variables

- `dynamodb_tables`: List of DynamoDB table configurations.


### 4. App Module

The app module handles the deployment of application-related resources. It dynamically creates IAM roles, EC2 instances, and other necessary components based on the provided configurations.

#### Variables

- `public_subnets`: List of public subnets.
- `security_group_ids`: List of security group IDs.
- `iam_instance_profile`: The IAM instance profile.
- `iam_user_name`: The IAM user name.
- `policy_name`: The IAM policy name.
- `configuration`: Map of application configurations.
- `instance_profile_name`: The IAM instance profile name.
- `key_name`: The EC2 key name.


### 5. Load Balancer Module

The load balancer module sets up an application load balancer to distribute incoming traffic among multiple services dynamically created in the app module.

#### Variables

- `services`: Map of services to be load-balanced.
- `vpc_id`: The ID of the VPC.
- `port`: The port to configure on the load balancer.
- `public_subnets_ids`: List of public subnet IDs.
- `security_group_ids`: List of security group IDs.

#### Outputs

- `target_group_arns`: List of target group ARNs.

### 6. AutoScaling Module

This module manages auto-scaling configurations for EC2 instances based on the dynamically created services. It ensures that the infrastructure scales based on demand.

#### Variables

- `instances_ids`: List of EC2 instance IDs.
- `services_names`: List of service names.
- `min_instances`: Minimum number of instances in the auto-scaling group.
- `desired_instances`: Desired number of instances in the auto-scaling group.
- `max_instances`: Maximum number of instances in the auto-scaling group.
- `public_subnets_ids`: List of public subnet IDs.
- `services`: Map of services with their names and IDs.
- `target_group_arn`: List of target group ARNs.
- `azs`: List of availability zones.

## Dynamic Code and Loops

The Terraform configurations in this repository leverage the power of dynamic code and loops to create and manage multiple resources efficiently. For example, the app and load balancer modules dynamically create resources for each service in the provided list, eliminating the need for manual configurations.

## Usage

### Setting up the Infrastructure

1. **Clone this repository.**

```bash
git clone https://github.com/your/repository.git
cd repository
```

2. **Initialize Terraform.**

```bash
terraform init
```

3. **Customize your environment by modifying the `terraform.tfvars` file.**

4. **Apply the Terraform configuration.**

```bash
terraform apply
```

### Deploying in Different Environments

To deploy the infrastructure in a different environment (e.g., dev vs. production), create separate Terraform configuration files, such as `terraform.dev.tfvars` and `terraform.prod.tfvars`. Adjust the variable values based on your environment requirements.

Apply the configuration using:

```bash
terraform apply -var-file=terraform.dev.tfvars
```
or
```bash
terraform apply -var-file=terraform.prod.tfvars
```

Cleanup

To destroy the created infrastructure, run:
```bash
terraform destroy
```