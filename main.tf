provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
# У разі потреби можемо вказати шлях до ssh ключа, за допомогою якого ми будемо під'єднюватись до наших серверів
/*resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file("D:/SoftServe/DevOps/AWS/public_aws.pem")
}
*/