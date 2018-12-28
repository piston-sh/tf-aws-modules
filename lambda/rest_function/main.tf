resource "aws_lambda_function" "rest_function" {
  count = "${length(var.function_key_map)}"

  s3_bucket = "${var.s3_bucket_id}"
  s3_key    = "${lookup(values(var.function_key_map), count.index)}"

  function_name = "${var.cluster_name}_${lookup(keys(var.function_key_map), count.index)}"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "${var.handler}"
  timeout       = "${var.function_timeout}"

  runtime = "${var.runtime}"
}

resource "aws_lambda_permission" "rest_function_api_gateway_permission" {
  count = "${length(var.function_key_map)}"

  statement_id = "${var.cluster_name}_${lookup(keys(var.function_key_map), count.index)}_allow_execution_from_gateway"

  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.rest_function.*.function_name}"

  principal = "apigateway.amazonaws.com"

  source_arn = "${var.rest_api_execution_arn}/*/*/*"
}

resource "aws_lambda_permission" "rest_function_release_bucket_permission" {
  count = "${length(var.function_key_map)}"

  statement_id = "${var.cluster_name}_${lookup(keys(var.function_key_map), count.index)}_release_bucket_permission"

  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.rest_function.*.arn}"

  principal  = "s3.amazonaws.com"
  source_arn = "${var.s3_bucket_arn}"
}

data "aws_region" "current" {}
