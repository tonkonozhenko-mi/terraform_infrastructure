provider "aws" {
  region     = var.aws_region
  shared_credentials_file = "%USERPROFILE%/.aws/credentials"
}
/*resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file("D:/SoftServe/DevOps/AWS/public_aws.pem")
}
*/