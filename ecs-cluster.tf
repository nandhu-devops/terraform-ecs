resource "aws_ecs_cluster" "main" {
  name = "Gallant"
}
 

data "template_file" "nginx" {
  template = file("./templates/test-app.json")

 
vars  = {
    app_image      = "${var.app_image}"
    ami_id     = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    volume = "${var.volume}"
    key-pair   = "${var.key-pair}"
    ec2_cpu    = "${var.ec2_cpu}"
    ec2_memory = "${var.ec2_memory}"
    aws_region     = "${var.aws_region}"
    app_port       = "${var.app_port}"
  }
}
#data "aws_ecs_task_definition" "nginx"{
#  task_definition = "${aws_ecs_task_definition.nginx.family}"
#}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  requires_compatibilities = ["EC2"]
  #execution_role_arn       = "${var.ecs_task_execution_role}"
  network_mode             = "bridge"
  volume {
    name   = "service-storage"
  }
 
#  aws_iam_role             = "ecsTaskExecutionRole"
  cpu                      = "${var.ec2_cpu}"
  memory                   = "${var.ec2_memory}"
  container_definitions    = file("task-definitions/service.json")
}

resource "aws_ecs_service" "main" {
  launch_type     = "EC2"
  task_definition = "${aws_ecs_task_definition.nginx.arn}"
  cluster         = "${aws_ecs_cluster.main.id}"
  name            = "nginx-123"
  scheduling_strategy = "REPLICA"
  #iam_role   = "${aws_iam_role.ecs_service_role.arn}"
  #depends_on = ["aws_iam_role_policy.ecs_service_role_policy"]
  desired_count   = "${var.app_count}"
  deployment_maximum_percent = "200"
  deployment_minimum_healthy_percent = "100"
  deployment_controller {
    type = "ECS"
}
  #network_configuration {
   # security_groups  = ["sg-043d93890c94ab282"]
   # vpc_id           = "vpc-02e381e045f52065b"
    #subnets          = ["subnet-06b99945ef26fe0b2", "subnet-0909bbfbe713b8670"]
    #assign_public_ip = false 
  #}

  load_balancer {
   # elb_name   = "Application" 
    target_group_arn = "${aws_alb_target_group.target_group.arn}"
    container_name   = "Gallant-task"
    container_port   = "${var.app_port}"
  }
  depends_on = [
    "aws_alb_listener.alb_listener",
  ]
  placement_constraints{
   type  =  "memberOf"
   expression = "attribute:ecs.availability-zone in [us-east-1a, us-east-1b]"
}

}
