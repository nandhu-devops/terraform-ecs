resource "aws_alb" "main" {
  name            = "test-lb"
  load_balancer_type = "application"
  ip_address_type  = "ipv4"
#subnets = "${compact(split(",", var.subnets["subnets_db"]))}"
security_groups = ["sg-043d93890c94ab282"]
  subnets         = ["subnet-06b99945ef26fe0b2","subnet-0909bbfbe713b8670"]
}

resource "aws_alb_target_group" "target_group" {
  name        = "test-tg"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = "vpc-02e381e045f52065b"
  target_type = "instance"

  health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "${var.health_check_path}"
    unhealthy_threshold = "2"
  }
}

#resource "aws_lb_target_group_attachment" "test123" {
#  target_group_arn = "${aws_alb_target_group.target_group.arn}"
#  target_id        = "${aws_ecs_task_definition.nginx.id}"
#}


# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = "${aws_alb.main.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    type             = "forward"
  }
}
