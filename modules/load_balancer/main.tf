resource "aws_lb_target_group" "target_groups" {
  for_each = var.services

  name        = each.value.name
  port        = var.port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path     = "/api/${each.value.name}/health"
    protocol = "HTTP"
    port     = var.port
  }

  tags = {
    Name = each.value.name
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachments" {
  for_each          = var.services
  target_group_arn = aws_lb_target_group.target_groups[each.key].arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb" "application_load_balancer" {
  name               = "project-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets_ids
  security_groups    = var.security_group_ids
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups["status"].arn
  }
}

resource "aws_lb_listener_rule" "target_group_rules" {
  for_each      = var.services
  listener_arn  = aws_lb_listener.http_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_groups[each.key].arn
  }

  condition {
    path_pattern {
      values = ["/api/${each.value.name}/*"]
    }
  }
}
