output "host_name" {
  value = local.host_name
}
variable "bucket_name" {
  type = string
}
variable "s3_logging_bucket" {
  type = string
}
variable "app_name" {
  type = string
}
variable "department" {
  type = string
}
variable "cloudfront_root" {
  type = string
}
locals {
  zone_name          = trimsuffix(data.aws_route53_zone.example_zone.name, ".")
  host_name          = "${var.app_name}.${local.zone_name}"
}
# DNS certificate exists at us_east-1 region
provider "aws" {
  region = "us-east-1"
  alias  = "us_east"
}
