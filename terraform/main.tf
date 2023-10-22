provider "aws" {
  region = "ap-southeast-3"  # Change to your desired region
}

# Create VPC
resource "aws_vpc" "vpc_devops1" {
  cidr_block = "172.12.0.0/23"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc_devops1"
  }
}

# Create Subnets
resource "aws_subnet" "subnet_devops1" {
  vpc_id     = aws_vpc.vpc_devops1.id
  cidr_block = "172.12.0.0/24"
  availability_zone = "ap-southeast-3a"  # Change to your desired availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_devops1"
  }
}

resource "aws_subnet" "subnet_devops2" {
  vpc_id     = aws_vpc.vpc_devops1.id
  cidr_block = "172.12.1.0/24"
  availability_zone = "ap-southeast-3b"  # Change to your desired availability zone
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_devops2"
  }
}

# Create Security Group
resource "aws_security_group" "allow_http_https" {
  name        = "allow_http_https"
  description = "Allow HTTP and HTTPS inbound traffic"
  vpc_id      = aws_vpc.vpc_devops1.id

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
}

# Create EC2 Instance
resource "aws_instance" "devops-mif-instance" {
  ami           = "ami-078c1149d8ad719a7"  # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-09-19
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.subnet_devops2.id
  security_groups = [aws_security_group.allow_http_https.name]

  tags = {
    Name = "devops-mif-instance"
  }
}
