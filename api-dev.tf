resource "aws_api_gateway_rest_api" "pica_dev_api" {
  count       = var.environment == "dev" ? 1 : 0
  name        = "pica-${var.environment}-api"
  description = "API gateway for pica proyect"
  lifecycle {

    ignore_changes = [description, name]
  }
}

resource "aws_api_gateway_stage" "pica_dev_stage" {
  count         = var.environment == "dev" ? 1 : 0
  deployment_id = aws_api_gateway_deployment.pica_dev_api_deployment[0].id
  rest_api_id   = aws_api_gateway_rest_api.pica_dev_api[0].id
  stage_name    = var.environment
}

resource "aws_api_gateway_deployment" "pica_dev_api_deployment" {
  count             = var.environment == "dev" ? 1 : 0
  depends_on        = [aws_api_gateway_integration.pica_dev_get_rate_integration[0]]
  rest_api_id       = aws_api_gateway_rest_api.pica_dev_api[0].id
  stage_description = "Deployment for develop stage"
}

// API CALCULATE

resource "aws_api_gateway_resource" "pica_dev_calculate_resource" {
  count       = var.environment == "dev" ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  parent_id   = aws_api_gateway_rest_api.pica_dev_api[0].root_resource_id
  path_part   = "calculate"
}

resource "aws_api_gateway_method" "pica_dev_calculate_method" {
  count                = var.environment == "dev" ? 1 : 0
  rest_api_id          = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id          = aws_api_gateway_resource.pica_dev_calculate_resource[0].id
  http_method          = "POST"
  authorization        = "COGNITO_USER_POOLS"
  authorizer_id        = aws_api_gateway_authorizer.pica_dev_api_authorizer[0].id
  authorization_scopes = ["pica-${var.environment}-server/write"]
}

resource "aws_api_gateway_integration" "pica_dev_post_calculate_integration" {
  count                   = var.environment == "dev" ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id             = aws_api_gateway_resource.pica_dev_calculate_resource[0].id
  http_method             = aws_api_gateway_method.pica_dev_calculate_method[0].http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda_dev_calculate[0].invoke_arn
}


//API RATE

resource "aws_api_gateway_resource" "pica_dev_rate_resource" {
  count       = var.environment == "dev" ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  parent_id   = aws_api_gateway_rest_api.pica_dev_api[0].root_resource_id
  path_part   = "rate"
}

resource "aws_api_gateway_method" "pica_dev_get_rate_method" {
  count                = var.environment == "dev" ? 1 : 0
  rest_api_id          = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id          = aws_api_gateway_resource.pica_dev_rate_resource[0].id
  http_method          = "GET"
  authorization        = "COGNITO_USER_POOLS"
  authorizer_id        = aws_api_gateway_authorizer.pica_dev_api_authorizer[0].id
  authorization_scopes = ["pica-${var.environment}-server/write"]
}

resource "aws_api_gateway_integration" "pica_dev_get_rate_integration" {
  count                   = var.environment == "dev" ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id             = aws_api_gateway_resource.pica_dev_rate_resource[0].id
  http_method             = aws_api_gateway_method.pica_dev_get_rate_method[0].http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda_dev_interase_rate[0].invoke_arn
}


//API INSURANCE


resource "aws_api_gateway_resource" "pica_dev_insurance_resource" {
  count       = var.environment == "dev" ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  parent_id   = aws_api_gateway_rest_api.pica_dev_api[0].root_resource_id
  path_part   = "insurance"
}

resource "aws_api_gateway_method" "pica_dev_get_insurance_method" {
  count                = var.environment == "dev" ? 1 : 0
  rest_api_id          = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id          = aws_api_gateway_resource.pica_dev_insurance_resource[0].id
  http_method          = "GET"
  authorization        = "COGNITO_USER_POOLS"
  authorizer_id        = aws_api_gateway_authorizer.pica_dev_api_authorizer[0].id
  authorization_scopes = ["pica-${var.environment}-server/write"]
}

resource "aws_api_gateway_integration" "pica_dev_get_insurance_integration" {
  count                   = var.environment == "dev" ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id             = aws_api_gateway_resource.pica_dev_insurance_resource[0].id
  http_method             = aws_api_gateway_method.pica_dev_get_insurance_method[0].http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.lambda_dev_insurance[0].invoke_arn
}


// preaproved 


resource "aws_api_gateway_resource" "pica_dev_preaproved_resource" {
  count       = var.environment == "dev" ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  parent_id   = aws_api_gateway_rest_api.pica_dev_api[0].root_resource_id
  path_part   = "preaproved"
}

resource "aws_api_gateway_method" "pica_dev_post_preaproved_method" {
  count                = var.environment == "dev" ? 1 : 0
  rest_api_id          = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id          = aws_api_gateway_resource.pica_dev_preaproved_resource[0].id
  http_method          = "POST"
  authorization        = "COGNITO_USER_POOLS"
  authorizer_id        = aws_api_gateway_authorizer.pica_dev_api_authorizer[0].id
  authorization_scopes = ["pica-${var.environment}-server/write"]
}

resource "aws_api_gateway_integration" "pica_dev_post_preapproved_integration" {
  count                   = var.environment == "dev" ? 1 : 0
  rest_api_id             = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id             = aws_api_gateway_resource.pica_dev_preaproved_resource[0].id
  http_method             = aws_api_gateway_method.pica_dev_post_preaproved_method[0].http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = "arn:aws:apigateway:${var.region}:states:action/StartSyncExecution"
  credentials             = aws_iam_role.step_role.arn


  request_templates = {
    "application/json" = <<EOT
{
  "stateMachineArn": "${aws_sfn_state_machine.pica_dev_preaproved_machine[0].arn}",
    #set($inputString = '')
    #set($allParams = $input.params())
    #set($inputString = "$inputString,@@body@@: $input.body")
    #set($inputString = "$inputString, @@headers@@:{")
    #foreach($paramName in $allParams.header.keySet())
        #set($inputString = "$inputString @@$paramName@@: @@$util.escapeJavaScript($allParams.header.get($paramName))@@")
        #if($foreach.hasNext)
            #set($inputString = "$inputString,")
        #end
    #end
    #set($inputString = "$inputString }")
    #set($inputString = "$inputString, @@path@@:@@$util.escapeJavaScript($context.resourcePath)@@")
    #set($inputString = "$inputString}")
    #set($inputString = $inputString.replaceAll("@@",'"'))
    #set($len = $inputString.length() - 1)
    "input": "{$util.escapeJavaScript($inputString.substring(1,$len))}"
}
EOT
  }
}

resource "aws_api_gateway_integration_response" "pica_dev_post_preapproved_integration_response" {
  count       = var.environment == "dev" ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id = aws_api_gateway_resource.pica_dev_preaproved_resource[0].id
  http_method = aws_api_gateway_method.pica_dev_post_preaproved_method[0].http_method
  status_code = "200"

  response_templates = {

    "application/json" = <<EOT
  {
  #set ($ObjOut = $util.parseJson($input.body))
  #if ($ObjOut.status == "SUCCEEDED")
    #set ($bodyObj = $util.parseJson($ObjOut.output))
    #set($context.responseOverride.status = $bodyObj.statusCode)
    #foreach($nameHeader in $bodyObj.headers.keySet())
        #set($context.responseOverride.header[$nameHeader] = "$bodyObj.headers.get($nameHeader)")
    #end
    $bodyObj.body
  #else
    #set($context.responseOverride.status = 500)
    {
        "code": "9998",
        "desc": "TECHNICAL_ERROR"
    }
  #end
  }
  EOT
  }
}

resource "aws_api_gateway_method_response" "pica_dev_method_response" {
  count       = var.environment == "dev" ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  resource_id = aws_api_gateway_resource.pica_dev_preaproved_resource[0].id
  http_method = aws_api_gateway_method.pica_dev_post_preaproved_method[0].http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Content-Type" = true
  }

  response_models = {
    "application/json" = "Empty" # Puedes ajustar el modelo según tus necesidades
  }
}



//COGNITO

resource "aws_api_gateway_resource" "pica_dev_oauth2_token" {
  count       = var.environment == "dev" ? 1 : 0
  parent_id   = aws_api_gateway_rest_api.pica_dev_api[0].root_resource_id
  path_part   = "authorizer"
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
}

resource "aws_api_gateway_method" "pica_dev_oauth2_token_post" {
  count         = var.environment == "dev" ? 1 : 0
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_resource.pica_dev_oauth2_token[0].id
  rest_api_id   = aws_api_gateway_rest_api.pica_dev_api[0].id
}

resource "aws_api_gateway_integration" "pica_dev_oauth2_token_integration" {
  count                   = var.environment == "dev" ? 1 : 0
  http_method             = aws_api_gateway_method.pica_dev_oauth2_token_post[0].http_method
  resource_id             = aws_api_gateway_resource.pica_dev_oauth2_token[0].id
  rest_api_id             = aws_api_gateway_rest_api.pica_dev_api[0].id
  type                    = "HTTP_PROXY"
  uri                     = "https://pica-dev.auth.us-east-1.amazoncognito.com/oauth2/token"
  integration_http_method = "POST"
}

resource "aws_api_gateway_integration_response" "pica_dev_oauth2_token_integration_response" {
  count       = var.environment == "dev" ? 1 : 0
  http_method = aws_api_gateway_method.pica_dev_oauth2_token_post[0].http_method
  resource_id = aws_api_gateway_resource.pica_dev_oauth2_token[0].id
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  status_code = "200"
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "pica_dev_oauth2_token_method_response" {
  count       = var.environment == "dev" ? 1 : 0
  http_method = aws_api_gateway_method.pica_dev_oauth2_token_post[0].http_method
  resource_id = aws_api_gateway_resource.pica_dev_oauth2_token[0].id
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration_response" "pica_dev_oauth2_token_integration_response_200" {
  count       = var.environment == "dev" ? 1 : 0
  http_method = aws_api_gateway_method.pica_dev_oauth2_token_post[0].http_method
  resource_id = aws_api_gateway_resource.pica_dev_oauth2_token[0].id
  rest_api_id = aws_api_gateway_rest_api.pica_dev_api[0].id
  status_code = "200"
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_authorizer" "pica_dev_api_authorizer" {
  count           = var.environment == "dev" ? 1 : 0
  name            = "pica-${var.environment}-cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.pica_dev_api[0].id
  type            = "COGNITO_USER_POOLS"
  identity_source = "method.request.header.Authorization"
  authorizer_uri  = aws_cognito_user_pool_domain.pica_dev_api_domain[0].domain
  provider_arns   = [aws_cognito_user_pool.pica_dev_pool[0].arn]
}
