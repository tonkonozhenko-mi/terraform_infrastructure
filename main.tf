provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
/*resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file("D:/SoftServe/DevOps/AWS/public_aws.pem")
}
*/