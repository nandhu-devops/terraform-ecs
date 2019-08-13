
resource "aws_autoscaling_group" "ecs-asg" {
    launch_configuration    =   "${aws_launch_configuration.ecs-asg-conf.id}"
    availability_zones  =   ["us-east-1a","us-east-1b"]
    name            =   "${aws_ecs_cluster.main.name}"
    max_size    =   "${var.max_size}"
    min_size    =   "${var.min_size}"
    health_check_grace_period =     "${var.health_check_grace_period}"
    #health_check_type   =     "${var.health_check_type}"
    desired_capacity    =   "${var.desired_capacity}"
    vpc_zone_identifier =   ["subnet-06b99945ef26fe0b2","subnet-0909bbfbe713b8670"]
#target_group_arns = ["${split(",", var.target_group_arns)}"]
   tag {
    key = "Env"
    value = "${var.environment_name}"
    propagate_at_launch = true
  }

  tag {
    key = "Name"
    value =  "ECS ${var.cluster_name}"
    propagate_at_launch = true
  }


  }

resource "aws_launch_configuration" "ecs-asg-conf" {
    name_prefix =   "${var.cluster_name}"
    image_id    =   "${var.ami_id}"
    instance_type   =   "${var.instance_type}"
    iam_instance_profile    =   "${var.iam}"
    key_name        =   "${var.keyname}"
    security_groups = ["sg-043d93890c94ab282"]
    user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.cluster_name}' > /etc/ecs/ecs.config"

lifecycle {
    create_before_destroy = true
  }
#provisioner "local-exec" {
 #   command = "sleep 15"
 # }
}



