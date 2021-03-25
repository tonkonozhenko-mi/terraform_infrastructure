resource "aws_instance" "backend_server_1" {
  ami                         = var.aws_instance_ami # Ubuntu 20.4
  instance_type               = var.aws_instance_type
  key_name                    = "ssh-key"
  user_data                   = file("3.backend_install.sh")
  vpc_security_group_ids      = [aws_security_group.backend_server.id]
  subnet_id                   = aws_subnet.eSchool_private.id
  private_ip                  = var.aws_instance_privat_ip_BackEnd_1
  associate_public_ip_address = true
  tags = {
    Name = "BE_1 server"
  }
}

resource "aws_instance" "backend_server_2" {
  ami                         = "ami-08962a4068733a2b6" # Ubuntu 20.4
  instance_type               = "t2.micro"
  key_name                    = "ssh-key"
  user_data                   = file("3.backend_install.sh")
  vpc_security_group_ids      = [aws_security_group.backend_server.id]
  subnet_id                   = aws_subnet.eSchool_private.id
  private_ip                  = var.aws_instance_privat_ip_BackEnd_2
  associate_public_ip_address = true
  tags = {
    "Name" = "BE_2 server"
  }
}

resource "aws_security_group" "backend_server" {
  name        = "BackEnd Security Group"
  description = "BE security group"
  vpc_id      = aws_vpc.eSchool_VPC.id
  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "backend"
  }
}
