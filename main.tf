terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0df24e148fdb9f1d8"
  instance_type = "t2.micro"

  tags = {
    Name = "VaroonTerraformInstance"
  }
}
