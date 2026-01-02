terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

# --------- Provider Config ---------
provider "aws" {
  region = "eu-west-1"
}

# --------- VPC ---------
resource "aws_vpc" "minecraft_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "minecraft-vpc" }
}

# --------- Subnet ---------
resource "aws_subnet" "minecraft_subnet" {
  vpc_id                  = aws_vpc.minecraft_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"

  tags = { Name = "minecraft-subnet" }
}

# --------- Internet Gateway ---------
resource "aws_internet_gateway" "minecraft_gw" {
  vpc_id = aws_vpc.minecraft_vpc.id

  tags = { Name = "minecraft-gateway" }
}

# --------- Route Table ---------
resource "aws_route_table" "minecraft_rt" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_gw.id
  }

  tags = { Name = "minecraft-route-table" }
}

resource "aws_route_table_association" "minecraft_assoc" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.minecraft_rt.id
}

# --------- Security Group ---------
resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft-sg"
  description = "Allow Minecraft traffic and SSM"
  vpc_id      = aws_vpc.minecraft_vpc.id

  ingress {
    description = "Minecraft"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSM (TCP 22 optional, not needed)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "minecraft-sg" }
}

# --------- Latest Amazon Linux 2 AMI ---------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# --------- IAM Role for SSM ---------
resource "aws_iam_role" "minecraft_ssm_role" {
  name = "minecraft-ssm-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "minecraft_ssm_attach" {
  role       = aws_iam_role.minecraft_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "minecraft_ssm_profile" {
  name = "minecraft-ssm-profile"
  role = aws_iam_role.minecraft_ssm_role.name
}

# --------- EC2 Instance ---------
resource "aws_instance" "minecraft" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.minecraft_subnet.id
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.minecraft_ssm_profile.name

  # Setup Ansible connectie
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y python3 git
              EOF

  tags = { Name = "minecraft-server" }
}

# --------- Outputs ---------
output "minecraft_instance_id" {
  description = "Instance ID for SSM connection"
  value       = aws_instance.minecraft.id
}

output "minecraft_public_ip" {
  description = "Public IP address"
  value       = aws_instance.minecraft.public_ip
}

