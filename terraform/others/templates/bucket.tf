resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  cors_rule {
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    allowed_origins = ["*"]
  }
 

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

 
  logging {
    target_bucket = var.s3_logging_bucket
    target_prefix = "${var.app_name}/s3"
  }

 

  tags = {
    "ManagedBy" = "Terraform"
    "Department"     = var.department
  }
}


# data "aws_iam_policy_document" "s3_policy" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["${aws_s3_bucket.bucket.arn}/*"]

 

#     principals {
#       type        = "AWS"
#       identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
#     }
#   }
# }

 

# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.bucket.id
#   policy = data.aws_iam_policy_document.s3_policy.json
# }

 

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

 #check what is necessary

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}