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

resource "aws_eip" "static_ip" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags             = {}
  instance = aws_instance.web_server[0].id
}

resource "aws_instance" "web_server" {
    count = 1
    ami = "ami-0c9354388bb36c088"
    instance_type = "t3.nano"
    vpc_security_group_ids = [aws_security_group.web_server_g.id]
    tags = {
        Name = "WebServer"
    }

    user_data = templatefile("./scripts/user_data.tpl", {
    name1 = "AWS",
    name2 = "Teraform"
    })

    lifecycle {
    create_before_destroy = true
    }
}

locals {
    name = ["http", "https"]
    ports = [80, 443]
}

resource "aws_security_group" "web_server_g" {
    name        = "Web Server Security Group"
    description = "Allow TLS 80, 443 Security Group"

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

output "webserver_aws_instance" {
 value = aws_instance.web_server[0].id
}

output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.web_server[0].public_ip
}