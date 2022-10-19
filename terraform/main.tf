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
