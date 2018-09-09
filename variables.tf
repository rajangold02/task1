variable "access_key" {}
variable "secret_key" {}
variable "aws_region" {}

variable "key_name" {
  default = "smartcity"
}

variable "vpc_id" {
  default = "vpc-881a21f3"
}

variable "aws_id" {
  default = "ami-04681a1dbd79675a5"
}

variable "subnet_id" {
  default = "subnet-6931a423"
}

variable "instance_type" {
  default = "t2.micro"
}
variable "name" {
  default = "elb"
}
