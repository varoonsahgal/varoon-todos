terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

data "aws_caller_identity" "current" {}

variable "access_key" {
  description = "AWS access_key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret_key"
  type        = string
  sensitive   = true
}

# Configure the AWS Provider
provider "aws" {
    region="us-west-2"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

resource "aws_instance" "app_server" {
  ami           = "ami-0df24e148fdb9f1d8"
  instance_type = "t2.micro"

  tags = {
    Name = "VaroonTerraformInstance"
  }
}
