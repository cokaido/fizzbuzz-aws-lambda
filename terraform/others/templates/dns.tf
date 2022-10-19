data "aws_route53_zone" "example_zone" {
  name = "example.es." //domain sufix .. app name will be before this
}
resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.example_zone.zone_id
  name    = local.host_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = true
  }
  lifecycle {
    prevent_destroy = true
  }
}
