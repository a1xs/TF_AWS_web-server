#
variable "ami" {
  type = map

  default = {
    "eu-central-1" = "ami-0c9354388bb36c088"
    "eu-west-1" = "ami-096800910c1b781ba"
  }
}

variable "instance_count" {
  default = "1"
}

variable "instance_tags" {
  type = list
  default = ["WebServer"]
}

variable "instance_type" {
  default = "t2.nano"
}

variable "aws_region" {
  default = "eu-central-1"
}
