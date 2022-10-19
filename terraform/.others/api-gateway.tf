//TODO : Parametrize domain example.es

# API Gateway
resource "aws_apigatewayv2_route" "fizzbuzz_lambda_route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /fizzbuzz"
  target    = "integrations/${aws_apigatewayv2_integration.fizzbuzz_lambda_integration.id}"
}

resource "aws_apigatewayv2_integration" "fizzbuzz_lambda_integration" {
  api_id               = aws_apigatewayv2_api.api_gateway.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  description          = "FizzBuzz Lambda"
  integration_method   = "POST"
  integration_uri      = aws_lambda_function.fizzbuzz_lambda.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

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








