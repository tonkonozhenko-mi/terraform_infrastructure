resource "aws_route_table" "eSchool_subnet_public" {
  vpc_id = aws_vpc.eSchool_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eSchool_igw.id
  }
  tags = {
    Name = "eSchool Route Table_public"
  }
}

resource "aws_route_table_association" "eSchool_subnet_public" {
  subnet_id      = aws_subnet.eSchool_public.id
  route_table_id = aws_route_table.eSchool_subnet_public.id
}
##################################

resource "aws_route_table" "eSchool_subnet_private" { 
  vpc_id = aws_vpc.eSchool_VPC.id 
  route { 
    cidr_block = "0.0.0.0/0" 
    nat_gateway_id = aws_nat_gateway.eschool_ngw.id
  } 
  tags ={ 
    Name = "eSchool Route Table_private" 
  } 
} 
 
resource "aws_route_table_association" "eSchool_subnet_private" {
  subnet_id = aws_subnet.eSchool_private.id 
  route_table_id = aws_route_table.eSchool_subnet_private.id 
} 