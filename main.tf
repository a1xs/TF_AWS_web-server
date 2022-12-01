#
variable "region" {}
variable "access_key" {}
variable "secret_key" {}
#
provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#resource "aws_eip" "my_static_ip" {
#  instance = aws_instance.WebServer.id
#}



resource "aws_instance" "WebServer" {
  count = 1
  ami = "ami-0c9354388bb36c088"
  instance_type = "t3.nano"
  vpc_security_group_ids = [aws_security_group.WebServer.id]
  tags = {
    Name = "WebServer"
  }
  user_data = file("./scripts/user_data")
}

locals {
  name = ["http", "https"]
  ports = [80, 443]
}

resource "aws_security_group" "WebServer" {
  name        = "Web Server Security Group"
  description = "Allow TLS 80 Security Group"

#  dynamic "ingress " {
#    for_each = local.ports
#    content {
#      description      = "http, https"
#      from_port        = ingress.value
#      to_port          = ingress.value
#      protocol         = "tcp"
#      cidr_blocks      = ["0.0.0.0/0"]
#      ipv6_cidr_blocks = ["::/0"]
#    }
#  }
  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
}

  ingress {
    description      = "http"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Web Server Security Group"
  }
}

#output "webserver_instence_ip" {
#  value = aws_instance.WebServer.host_id
#}

#output "webserver_public_ip" {
#  value = aws_eip.my_static_ip.public_ip
#}
