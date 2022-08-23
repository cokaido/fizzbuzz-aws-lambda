//TODO change lambda to Fizzbuzz Lambda
#Lambda

resource "aws_lambda_function" "fizzbuzz_lambda" {

  filename         = "../dist/index.zip"
  function_name    = "fizzbuzz"
  handler          = "fizzbuzz.handler"
  source_code_hash = filebase64sha256("../dist/index.zip")
  role             = aws_iam_role.iam_for_lambda.arn
  # layers           = [aws_lambda_layer_version.dependencies_layer.arn]
  runtime = "nodejs16.x"
}

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

resource "aws_lambda_permission" "fizzbuzz_lambda_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fizzbuzz_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}


# Cloudwatch group
resource "aws_cloudwatch_log_group" "fizzbuzz_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.fizzbuzz_lambda.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

