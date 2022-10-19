//TODO : Parametrize domain example.es

resource "aws_apigatewayv2_api" "api_gateway" {
  name          = var.app_name
  protocol_type = "HTTP"
  cors_configuration {

    allow_headers = ["*"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }
}

resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  api_id = aws_apigatewayv2_api.api_gateway.id

  name        = "${var.app_name}_stage"
  auto_deploy = true
}

resource "aws_apigatewayv2_api_mapping" "api_gateway_mapping" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  domain_name = aws_apigatewayv2_domain_name.example-domain.id
  stage       = aws_apigatewayv2_stage.api_gateway_stage.id
}

resource "aws_apigatewayv2_domain_name" "example-domain" {
  domain_name = "${var.app_name}.example.es"

  domain_name_configuration {
    certificate_arn = data.aws_acm_certificate.certificate.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

data "aws_acm_certificate" "certificate" {
  domain   = "*.example.es"
  statuses = ["ISSUED"]
}

#END OF SETTINGS FOR ALL LAMBDAS








