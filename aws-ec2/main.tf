terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

variable "name" {
  description = "Name of the EC2 instance"
  type = string
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ssh-key"{
    key_name = "ssh-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_traffic" {
    name        = "allow_traffic"
    description = "Allow inbound traffic"

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

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  key_name = aws_key_pair.ssh-key.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffic.id ]

  user_data= file("${path.module}/init.sh")

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 20
    volume_type = "gp2"
  }
  
  tags = {
    Name = var.name
  }
}

output "ssh_public_ip" {
  description = "SSH into the EC2 by ubuntu@public_ip"
  value = "type ssh ubuntu@${aws_instance.app_server.public_ip}"
}
