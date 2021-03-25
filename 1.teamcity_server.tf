resource "aws_instance" "teamcity_server" {
  ami                         = var.aws_instance_ami # Ubuntu 20.4
  instance_type               = var.aws_instance_type_teamcity_server # Тип серверу
  key_name                    = "ssh-key"
  vpc_security_group_ids      = [aws_security_group.teamcity_server.id] 
  subnet_id                   = aws_subnet.eSchool_public.id # публічна підмережа
  private_ip                  = var.aws_instance_public_ip_TeamCity
  associate_public_ip_address = true
  tags = {
    Name = "TeamCity Server"
  }

  provisioner "file" {
    source      = "D:/SoftServe/Terraform_experiment/Eschool/inf/1.teamcity_install.sh"
    destination = "/home/ubuntu/teamcity_install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/teamcity_install.sh",
      "sudo /home/ubuntu/teamcity_install.sh",
    ]
  }

  # Логін на сервер використовуючи приватний ключ.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("D:/SoftServe/DevOps/AWS/privat_aws")
    host        = self.public_ip
  }
}
resource "aws_instance" "teamcity_agent" {
  ami                         = var.aws_instance_ami # Ubuntu 20.4
  instance_type               = var.aws_instance_type_teamcity_server
  key_name                    = "ssh-key"
  vpc_security_group_ids      = [aws_security_group.teamcity_server.id]
  subnet_id                   = aws_subnet.eSchool_public.id
  private_ip                  = var.aws_instance_public_ip_TeamCity_agent
  associate_public_ip_address = true
  tags = {
    Name = "TeamCity Agent"
  }
 provisioner "file" {
    source      = "D:/SoftServe/Terraform_experiment/Eschool/inf/1.teamcity_agent_install.sh"
    destination = "/home/ubuntu/teamcity_agent_install.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/teamcity_agent_install.sh",
      "sudo /home/ubuntu/teamcity_agent_install.sh",
    ]
  }

  # Логін на сервер використовуючи приватний ключ.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file("D:/SoftServe/DevOps/AWS/privat_aws")
    host        = self.public_ip
  }
}
resource "aws_eip" "teamcity_server" { 
  vpc      = true
	instance = aws_instance.teamcity_server.id
	associate_with_private_ip = "10.0.1.4"
	depends_on = [aws_internet_gateway.eSchool_igw]
}

resource "aws_security_group" "teamcity_server" {
  name        = "TeamCity Security Group"
  description = "TeamCity security group"
  vpc_id      = aws_vpc.eSchool_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8111
    to_port     = 8111
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
    Name = "teamcity"
  }
}
