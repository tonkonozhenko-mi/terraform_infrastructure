resource "aws_internet_gateway" "eSchool_igw" {
  vpc_id = aws_vpc.eSchool_VPC.id

  tags = {
    Name = "eSchool - Internet Gateway"
  }
}