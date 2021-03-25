resource "aws_instance" "bastion_server" {
  ami                         = var.aws_instance_ami # Ubuntu 20.4
  instance_type               = var.aws_instance_type
  key_name                    = "ssh-key"
  vpc_security_group_ids      = [aws_security_group.bastion_server.id]
  subnet_id                   = aws_subnet.eSchool_public.id
  private_ip                  = var.aws_instance_public_ip_bastion
  associate_public_ip_address = true
  tags = {
    Name = "Bastion Server"
  }
}

resource "aws_eip" "bastion_server" { 
  vpc      = true
	instance = aws_instance.load_balancer_server.id
	associate_with_private_ip = "10.0.1.10"
	depends_on = [aws_internet_gateway.eSchool_igw]
}

resource "aws_security_group" "bastion_server" {
  name        = "Bastion Security Group"
  description = "Fisrt security group"
  vpc_id      = aws_vpc.eSchool_VPC.id

  ingress {
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
  tags = {
    Name = "bastion"
  }
}