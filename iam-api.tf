resource "aws_lambda_permission" "pica_dev_api" {
  count         = var.environment == "dev" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dev_interase_rate[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.pica_dev_api[0].execution_arn}/*/${aws_api_gateway_method.pica_dev_get_rate_method[0].http_method}${aws_api_gateway_resource.pica_dev_rate_resource[0].path}"
}

resource "aws_lambda_permission" "pica_pro_api" {
  count         = var.environment == "pro" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_pro_interase_rate[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.pica_pro_api[0].execution_arn}/*/${aws_api_gateway_method.pica_pro_get_rate_method[0].http_method}${aws_api_gateway_resource.pica_pro_rate_resource[0].path}"
}

resource "aws_lambda_permission" "pica_dev_insurance_permitions_api" {
  count         = var.environment == "dev" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dev_insurance[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.pica_dev_api[0].execution_arn}/*/${aws_api_gateway_method.pica_dev_get_insurance_method[0].http_method}${aws_api_gateway_resource.pica_dev_insurance_resource[0].path}"
}

resource "aws_lambda_permission" "pica_pro_insurance_permitions_api" {
  count         = var.environment == "pro" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_pro_insurance[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.pica_pro_api[0].execution_arn}/*/${aws_api_gateway_method.pica_pro_get_insurance_method[0].http_method}${aws_api_gateway_resource.pica_pro_insurance_resource[0].path}"
}

resource "aws_lambda_permission" "pica_dev_calculate_permitions_api" {
  count         = var.environment == "dev" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_dev_calculate[0].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.pica_dev_api[0].execution_arn}/*/${aws_api_gateway_method.pica_dev_calculate_method[0].http_method}${aws_api_gateway_resource.pica_dev_calculate_resource[0].path}"
}


