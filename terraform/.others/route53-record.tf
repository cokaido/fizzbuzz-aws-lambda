//TODO: Parametrize domain

data "aws_route53_zone" "example_zone" {
  name = "example.es." //domain sufix .. app name will be before this
}

resource "aws_route53_record" "example" {
  name    = aws_apigatewayv2_domain_name.example-domain.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.example_zone.id

  alias {
    evaluate_target_health = true
    name                   = aws_apigatewayv2_domain_name.example-domain.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.example-domain.domain_name_configuration[0].hosted_zone_id
  }
}
