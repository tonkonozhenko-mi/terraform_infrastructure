resource "aws_instance" "FrontEnd_server" {
  ami                         = var.aws_instance_ami # Ubuntu 20.4
  instance_type               = var.aws_instance_type
  key_name                    = "ssh-key"
  user_data                   = file("4.frontend_install.sh")
  vpc_security_group_ids      = [aws_security_group.FrontEnd_server.id]
  subnet_id                   = aws_subnet.eSchool_public.id
  private_ip                  = var.aws_instance_public_ip_FrontEnd
  associate_public_ip_address = true
  tags = {
    Name = "FE Server"
  }
}

resource "aws_eip" "frontend_server" { 
  vpc      = true
	instance = aws_instance.FrontEnd_server.id
	associate_with_private_ip = "10.0.1.6"
	depends_on = [aws_internet_gateway.eSchool_igw]
}

resource "aws_security_group" "FrontEnd_server" {
  name        = "FrontEnd Security Group"
  description = "FE security group"
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
    Name = "frontend"
  }
}