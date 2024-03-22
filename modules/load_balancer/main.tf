# Resource block for creating target groups
resource "aws_lb_target_group" "target_groups" {
  for_each = var.services

  name        = each.value.name          # Name of the target group
  port        = var.port                 # Port for the target group
  protocol    = "HTTP"                   # Protocol for communication
  vpc_id      = var.vpc_id               # VPC ID for the target group

  # Health check configuration for the target group
  health_check {
    path     = "/api/${each.value.name}/health"  # Path for health checks
    protocol = "HTTP"                            # Protocol for health checks
    port     = var.port                          # Port for health checks
  }

  tags = {
    Name = each.value.name  # Tag for identifying the target group
  }
}

# Resource block for attaching instances to target groups
resource "aws_lb_target_group_attachment" "target_group_attachments" {
  for_each          = var.services
  target_group_arn = aws_lb_target_group.target_groups[each.key].arn
  target_id        = each.value.id
  port             = 80  # Port for target group attachments
}

# Resource block for creating the application load balancer
resource "aws_lb" "application_load_balancer" {
  name               = "project-lb"               # Name of the load balancer
  internal           = false                      # Whether the load balancer is internal or external
  load_balancer_type = "application"             # Type of load balancer (application or network)
  subnets            = var.public_subnets_ids     # Subnets for the load balancer
  security_groups    = var.security_group_ids     # Security groups for the load balancer
}

# Resource block for creating HTTP listener for the load balancer
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80             # Port for the listener
  protocol          = "HTTP"         # Protocol for the listener

  # Default action for the listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups["status"].arn  # Target group ARN for default action
  }
}

# Resource block for creating listener rules for the load balancer
resource "aws_lb_listener_rule" "target_group_rules" {
  for_each      = var.services
  listener_arn  = aws_lb_listener.http_listener.arn

  # Action for the listener rule
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups[each.key].arn  # Target group ARN for the action
  }

  # Condition for the listener rule
  condition {
    path_pattern {
      values = ["/api/${each.value.name}/*"]  # Path pattern for the condition
    }
  }
}
