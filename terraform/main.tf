terraform {
  required_version = "~0>0.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"

}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-2070"
  }

}


resource "aws_subnet" "subnet-public" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1./24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "r_table" {
  vpc_id = aws_vpc.myvpc.id

}

resource "aws_route" "r_entry" {
  route_table_id         = aws_route_table.r_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "r_associate" {
  route_table_id = aws_route_table.r_table.id
  subnet_id      = aws_subnet.subnet-public.id

}

resource "aws_security_group" "sg" {
  name        = "ec2-2070-sg"
  description = "SG for ec2 server for 2070Health"
  vpc_id      = aws_vpc.myvpc.id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]


  }
}


resource "tls_private_key" "key-generate" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "tf-ec2-key"
  public_key = tls_private_key.key-generate.public_key_openssh
}


resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type //"t2.micro"
  subnet_id     = aws_subnet.subnet-public.id
  key_name      = aws_key_pair.generated_key.key_name
}
