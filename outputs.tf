############################### Адреса TeamCity сервера
output "teamcity_id" {
  description = "ID of the TeamCity"
  value       = aws_instance.teamcity_server.id
}
output "teamcity_public_ip" {
  description = "Public IP address of the TeamCity"
  value       = aws_instance.teamcity_server.public_ip
}
############################### Адреса TeamCity агента
output "teamcity_agent_id" {
  description = "ID of the TeamCity agent"
  value       = aws_instance.teamcity_agent.id
}
output "teamcity_agent_public_ip" {
  description = "Public IP address of the TeamCity agent"
  value       = aws_instance.teamcity_agent.public_ip
}
############################### Адреса Load Balancer
output "loadbalancer_id" {
  description = "ID of the LoadBalancer"
  value       = aws_instance.load_balancer_server.id
}
output "loadbalancer_public_ip" {
  description = "Public IP address of the LoadBalancer"
  value       = aws_instance.load_balancer_server.public_ip
}
############################### Адреса FrontEnd
output "frontend_id" {
  description = "ID of the FrontEnd"
  value       = aws_instance.FrontEnd_server.id
}
output "frontend_public_ip" {
  description = "Public IP address of the FrontEnd"
  value       = aws_instance.FrontEnd_server.public_ip
}
############################### Адреса Data Base
output "database_id" {
  description = "ID of the DataBase"
  value       = aws_instance.DB_server.id
}
output "public_ip_database" {
  description = "Public IP address of the DataBase"
  value       = aws_instance.DB_server.public_ip
}
############################### Адреса BackEnd - 1
output "backend_server_1_id" {
  description = "ID of the BackEnd-1"
  value       = aws_instance.backend_server_1.id
}
output "public_ip_backend-1" {
  description = "Public IP address of the BackEnd-1"
  value       = aws_instance.backend_server_1.public_ip
}
############################### Адреса BackEnd - 2
output "backend_server_2_id" {
  description = "ID of the BackEnd-2"
  value       = aws_instance.backend_server_2.id
}
output "public_ip_backend-2" {
  description = "Public IP address of the BackEnd-2"
  value       = aws_instance.backend_server_2.public_ip
}
############################### Адреса Bastion
output "bastion_server_id" {
  description = "ID of the Bastion"
  value       = aws_instance.bastion_server.id
}
output "public_ip_bastion" {
  description = "Public IP address of the Bastion"
  value       = aws_instance.bastion_server.public_ip
}
############################### ID Internet Gateway
output "IGW_id" {
	description = "ID of the IGW"
	value = aws_internet_gateway.eSchool_igw.id
}
############################### ID Nat
output "Eschool_nat" {
	description = "ID of the NAT"
	value = aws_eip.eschool_nat.id
}
############################### ID VPC
output "Eschool_voc" {
	description = "ID of the VPC"
	value = aws_vpc.eSchool_VPC.id
}
############################### ID Public підмережі
output "Eschool_subnet_public" {
	description = "ID of the public subnet"
	value = aws_subnet.eSchool_public.id
}
############################### ID Privat підмережі
output "Eschool_subnet_private" {
	description = "ID of the private subnet"
	value = aws_subnet.eSchool_private.id
}
############################### Elastic IP TeamCity сервера
output "aws_eip_teamcity_server" {
	description = "Elastic IP of the teamcity server"
	value = aws_eip.teamcity_server.id
}
############################### Elastic IP Load Balancer сервера
output "aws_eip_load_balancer_server" {
	description = "Elastic IP of the load balancer server"
	value = aws_eip.load_balancer_server.id
}
############################### Elastic IP FrontEnd сервера
output "aws_eip_frontend_server" {
	description = "Elastic IP of the frontend server"
	value = aws_eip.frontend_server.id
}