resource "aws_iam_instance_profile" "ecs" {
    name = "ecs-service-${var.nginx}-role-iam"
    roles = ["${aws_iam_role.ecs_service_role.name}"]
}

resource "aws_iam_role" "ecs_service_role" {
    name = "ecs-service-${var.nginx}-role"
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ecs.amazonaws.com",
          "ec2.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
