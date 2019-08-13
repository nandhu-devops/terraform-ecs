#data "aws_availability_zones" "available" {}

#resource "aws_vpc" "main" {
#  cidr_block = "10.0.0.0/26" 
#  vpc_id = "vpc-0d1eb410d790a6abe"
#}


# public subnets, each in a different AZ
#resource "aws_subnet" "public-a" {
#  #count                   = "${var.az_count}"
#  subnet_id         = "subnet-03cabd185ebb72657"
#  vpc_id                  = "vpc-0d1eb410d790a6abe"
#  cidr_block = "10.0.0.0/28"
#  map_public_ip_on_launch = true
#}

#resource "aws_subnet" "public-b" {
 # count                   = "${var.az_count}"
#  subnet_id         = "subnet-00f3c0824ac01a740"
#  vpc_id                  = "vpc-0d1eb410d790a6abe"
  # map_public_ip_on_launch = true
#    cidr_block = "10.0.0.16/28"
#}
# IGW for the public subnet

#resource "aws_internet_gateway" "gw" {
#  vpc_id = "vpc-0d1eb410d790a6abe"
#}

# Route the public subnet trafic through the IGW
#resource "aws_route" "internet_access" {
#  route_table_id         = "rtb-0916726d8f27bf161"
#  destination_cidr_block = "0.0.0.0/0"
#  gateway_id             = "igw-0625d9ff168305d3d"
#}

