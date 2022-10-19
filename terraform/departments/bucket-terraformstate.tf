resource "aws_s3_bucket" "department-terraform-state" {
  bucket = "${var.department}-terraform-state"
  lifecycle {
    prevent_destroy = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    "ManagedBy" = "Terraform"
    "Project"   = "Department bootstrap"
    "Deparment" = var.department
  }
}
resource "aws_s3_bucket_public_access_block" "bucket-public_access_block" {
  bucket = aws_s3_bucket.department-terraform-state.id
  #Check each of these paramenters
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
