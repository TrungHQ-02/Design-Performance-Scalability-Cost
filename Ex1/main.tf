# TODO: Designate a cloud provider, region, and credentials
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "lab_udacity"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

data "aws_security_group" "selected" {
  id = var.security_group_id
}

data "aws_ami" "selected" { // AMZ Linux 2023
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-07caf09b362be10b8"]
  }
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity_t2" {
  count         = 4
  ami           = data.aws_ami.selected.id // Enter your AMI ID
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected.id
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
# resource "aws_instance" "udacity_m4" {
#   count         = 2
#   ami           = data.aws_ami.selected.id // Enter your AMI ID
#   instance_type = "m4.large"
#   subnet_id     = data.aws_subnet.selected.id
#   tags = {
#     Name = "Udacity M4"
#   }
# }

## Modify delete M4
resource "aws_instance" "udacity_m4" {
  count         = 0
  ami           = data.aws_ami.selected.id // Enter your AMI ID
  instance_type = "m4.large"
  subnet_id     = data.aws_subnet.selected.id
  tags = {
    Name = "Udacity M4"
  }
}