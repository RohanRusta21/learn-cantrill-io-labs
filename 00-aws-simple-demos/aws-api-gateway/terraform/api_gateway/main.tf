resource "aws_api_gateway_rest_api" "api" {
  name = var.api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "example_mock" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "mock"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "mock_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example_mock.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_integration" "mock_integration" {
  http_method = aws_api_gateway_method.mock_method.http_method
  resource_id = aws_api_gateway_resource.example_mock.id
  rest_api_id = aws_api_gateway_rest_api.api.id
  type = "MOCK"
}

resource "aws_api_gateway_integration_response" "mock_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.example_mock.id
  http_method = aws_api_gateway_method.mock_method.http_method
  status_code = "200"

  response_templates = {
    "application/json" = "{\"message\": \"MOCKED RESPONSE FROM API GATEWAY\"}"
  }
}

resource "aws_api_gateway_resource" "example_lambda" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "lambda"
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "lambda_method" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example_lambda.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_integration" "lambda_integration" {
  http_method = aws_api_gateway_method.lambda_method.http_method
  resource_id = aws_api_gateway_resource.example_lambda.id
  rest_api_id = aws_api_gateway_rest_api.api.id
  type = "AWS_PROXY"
  uri = var.lambda_invoke_arn
}

resource "aws_api_gateway_integration_response" "lambda_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.example_lambda.id
  http_method = aws_api_gateway_method.lambda_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration_response.lambda_integration_response,
    aws_api_gateway_integration.mock_integration,
    aws_api_gateway_integration_response.mock_integration_response,
  ]
}


