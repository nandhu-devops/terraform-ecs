variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "cluster_name" {
 default = "Gallant"
}

variable "iam" {
 description = "The IAM Instance Profile)"
 default  = "ecsInstanceRole"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"

   default    = "nginx:latest"

}

variable "ami_id" {
      default = "ami-0fac5486e4cff37f4"
}
variable "keyname" {
   description = "SSH key name in aws account"
   default = "nandhu"
}

variable "instance_type" {
    default = "m5.large"
    description = "name of the instance type"
}

variable "min_size" {
    default = "2"
}

variable "max_size" {
    default = "6"
}

variable "desired_capacity" {
    default = "2"
}

variable "environment_name" {
    default = "AG"
    description = "Environment name to tag EC2 resources with (tag=environment)"
}
 
variable "volume" {
default = "22"
}
variable "nginx"{
default = "nginx-2"
}
variable "key-pair" {
  default = "nandhu"
}


variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = "80"
}

variable "ssh_port" {
  description = "to connect with local machine ssh"
  default     = "22"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = "2"
}

variable "ecs_autoscale_role" {
  description = "Role arn for the ecsAutoscaleRole"
 # default     = "arn:aws:iam::164883864750:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  default     = "AWSServiceRoleForAutoScaling_ECSService"
}

variable "ecs_task_execution_role" {
  description = "Role arn for the ecsTaskExecutionRole"
  #default     = "arn:aws:iam::164883864750:role/ecsTaskExecutionRole"
  default     = "ecsTaskExecutionRole"
}

variable "health_check_grace_period" {
    default = "300"
    description = "Time after instance comes into service before checking health"
}

variable "health_check_path" {
  default = "/"
}

variable "ec2_cpu" {
  description = "EC2 instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "ec2_memory" {
  description = "EC2 instance memory to provision (in MiB)"
 default     = "800"
}
