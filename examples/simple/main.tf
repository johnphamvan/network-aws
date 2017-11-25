data "aws_ami" "base" {
  most_recent = true
  owners      = ["${var.ami_owner}"]

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "network_aws" {
  source = "../../../network-aws"
  # source = "git@github.com:hashicorp-modules/network-aws.git?ref=f-refactor"

  name     = "${var.name}"
  image_id = "${data.aws_ami.base.id}"
}
