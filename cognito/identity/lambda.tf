resource "aws_lambda_function" "register_function" {
  s3_bucket     = var.lambda_s3_bucket_id
  s3_key        = var.lambda_s3_bucket_key
  function_name = "${var.name}_identity_register"
  role          = aws_iam_role.lambda.arn
  handler       = "${var.lambda_runtime == "go1.x" ? "${replace(var.name, "public_", "")}_identity_register" : var.lambda_handler}"
  timeout       = var.lambda_function_timeout
  runtime       = var.lambda_runtime
}

resource "aws_lambda_permission" "register_function_permission" {
  action        = "lambda:InvokeFunction"
  statement_id  = "${var.name}_identity_register_allow_execution_from_cognito"
  function_name = aws_lambda_function.register_function.arn
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.user_pool.arn
}
