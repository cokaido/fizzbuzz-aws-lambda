//TODO: Parametrize bucket prefix
variable "environment" {
  default = "training"
}
variable "app_name" {
  default = "fizzbuzz"
}

variable "region" {
  default = "us-west-2"
}

variable "department" {
  default = "software-engineering"
}

provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket         = "solid-software-engineering-terraform-state"
    dynamodb_table = "solid-software-engineering-tf-locks"
    region         = "us-west-2"
    #key provided by command line parameter
  }
}
