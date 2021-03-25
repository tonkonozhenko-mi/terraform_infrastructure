resource "aws_eip" "eschool_nat" { 
  vpc      = true
  } 
 
resource "aws_nat_gateway" "eschool_ngw" {
  allocation_id = aws_eip.eschool_nat.id 
  subnet_id = aws_subnet.eSchool_public.id 
}



 



