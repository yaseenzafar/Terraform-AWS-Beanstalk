provider "aws" {
  region = "us-east-2"
  access_key = "${var.aws_access_key}" #This should be hidden
  secret_key = "${var.aws_secret_key}" #This should be hidden
}