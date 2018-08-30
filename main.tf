provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "instance" {
  ami                         = "${var.aws_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${var.subnet_id}"
  security_groups             = ["${aws_security_group.allow.id}"]
  associate_public_ip_address = "true"

  tags {
    Name = "PhpInstance"
  }

  user_data = "${file("./php.sh")}"
}

resource "aws_security_group" "allow" {
  vpc_id      = "${var.vpc_id}"
  name        = "allow-ec2-sg"
  description = "security group that allows ssh,http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_sg"
  }
}

resource "aws_elb" "example" {
  name            = "${var.name}"
  subnets         = ["${var.subnet_id}"]
  security_groups = ["${aws_security_group.allow.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.php"
    interval            = 30
  }

  instances                   = ["${aws_instance.instance.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "php-elb"
  }
}
