resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Identity for ${var.app_name} to access S3-hosted web site"
}



resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = "${local.host_name}-origin"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }



  comment             = "${var.app_name} distribution"
  default_root_object = var.cloudfront_root
  enabled             = true
  aliases             = [local.host_name]
  # Price class supporting US, CA, EU and Israel
  # (see https://aws.amazon.com/cloudfront/pricing/)
  price_class = "PriceClass_100"



  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${local.host_name}-origin"



    # dynamic "function_association" {
    #   for_each = aws_cloudfront_function.security_header
    #   content {
    #     event_type   = "viewer-response"
    #     function_arn = aws_cloudfront_function.security_header[0].arn
    #   }
    # }



    forwarded_values {
      query_string = false
      headers = [
        "Origin",
        "Access-Control-Request-Headers",
        "Access-Control-Request-Method",
      ]
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "https-only"
    min_ttl                = 31536000 // 1-year, cache invalidation after deployment is needed
    default_ttl            = 31536000
    max_ttl                = 31536000
    compress               = true
  }



  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }



  viewer_certificate  {
    acm_certificate_arn      = data.aws_acm_certificate.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }


  logging_config {
    include_cookies = false
    bucket          = "${var.s3_logging_bucket}.s3.amazonaws.com"
    prefix          = "${var.app_name}/cloudfront"
  }



  lifecycle {
    prevent_destroy = true
  }



  # This is the ARN of the WAF. Comment this line to disable the WAF
  #web_acl_id = "arn:aws:wafv2:us-east-1:301029594617:global/webacl/my-account-wafstack/63e226a5-08fe-4df6-a0e2-3c798a6963e4"



  # web_acl_id = aws_cloudformation_stack.waf_stack.outputs.WAFWebACLArn
  # depends_on = [aws_cloudformation_stack.waf_stack]
}



data "aws_acm_certificate" "certificate" {
  provider = aws.us_east
  domain   = "*.example.es"
}

# resource "aws_acm_certificate" "cert" {
#   domain_name       = "example.es"
#   validation_method = "DNS"
#   provider = aws.us_east
#   tags = {
#     Environment = "test"
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }
