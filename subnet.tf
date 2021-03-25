resource "aws_subnet" "eSchool_public" {
  vpc_id            = aws_vpc.eSchool_VPC.id
  cidr_block        = var.aws_subnet_public
  availability_zone = var.availability_zone


  tags = {
    Name = "eSchool subnet_public"
	Access = "public" 
  }
}
resource "aws_subnet" "eSchool_private" {
  vpc_id            = aws_vpc.eSchool_VPC.id
  cidr_block        = var.aws_subnet_private
  availability_zone = var.availability_zone


  tags = {
    Name = "eSchool subnet_private"
	Access = "private"
  }
}