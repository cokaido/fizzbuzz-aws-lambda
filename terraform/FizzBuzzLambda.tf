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

#Lambda permissions
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

