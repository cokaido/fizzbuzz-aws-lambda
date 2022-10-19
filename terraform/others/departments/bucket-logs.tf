resource "aws_s3_bucket" "deparment-logs" {
  bucket = "${var.department}-logs"
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
    
  lifecycle_rule {
    id      = "log"
    enabled = true
    tags = {
      rule      = "log"
      autoclean = "true"
    }
    transition {
      days          = 30
      storage_class = "STANDARD_IA" 
    }
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
    expiration {
      days = 90
    }
  }
  tags = {
    "ManagedBy" = "Terraform"
    "Project"   = "Department bootstrap"
    "Department"     = var.department
  }
}
resource "aws_s3_bucket_public_access_block" "department-logs-public_access_block" {
  bucket = aws_s3_bucket.deparment-logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}