resource "aws_instance" "load_balancer_server" {
  ami                         = var.aws_instance_ami # Ubuntu 20.4
  instance_type               = var.aws_instance_type
  key_name                    = "ssh-key"
  user_data                   = file("5.load_balancer_install.sh")
  vpc_security_group_ids      = [aws_security_group.load_balancer_server.id]
  subnet_id                   = aws_subnet.eSchool_public.id
  private_ip                  = var.aws_instance_public_ip_LoadBalancer
  associate_public_ip_address = true
  tags = {
    Name = "LB Server"
  }
}

resource "aws_eip" "load_balancer_server" { 
  vpc      = true
	instance = aws_instance.load_balancer_server.id
	associate_with_private_ip = "10.0.1.7"
	depends_on = [aws_internet_gateway.eSchool_igw]
}

resource "aws_security_group" "load_balancer_server" {
  name        = "LB Security Group"
  description = "LB security group"
  vpc_id      = aws_vpc.eSchool_VPC.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "load_balancer"
  }
}
