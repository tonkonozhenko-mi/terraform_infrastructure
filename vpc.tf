resource "aws_vpc" "eSchool_VPC" {
  cidr_block       = var.aws_vpc
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "eSchool VPC"
  }
}
