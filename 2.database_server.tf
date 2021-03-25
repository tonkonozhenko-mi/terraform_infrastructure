resource "aws_instance" "DB_server" {                 # resource "тип провайдера_тип ресурсу" "придумати назва ресурсу"
  ami                         = var.aws_instance_ami  #  яку операційку встановити - Ubuntu Server 20.4
  instance_type               = var.aws_instance_type # тип серверу Free tier (1 vCPU, 1 Gb Ram)
  key_name                    = "ssh-key"
  user_data                   = file("2.database_install.sh")
  vpc_security_group_ids      = [aws_security_group.DB_server.id]
  subnet_id                   = aws_subnet.eSchool_private.id
  private_ip                  = var.aws_instance_privat_ip_DataBase
  associate_public_ip_address = true
  tags = {
    Name = "DB_Server" # Ім'я сервера
  }
}

resource "aws_security_group" "DB_server" {
  name        = "DB Security Group"
  description = "DB security group"
  vpc_id      = aws_vpc.eSchool_VPC.id
  ingress {
    from_port   = 3306
    to_port     = 3306
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
    Name = "database"
  }
}