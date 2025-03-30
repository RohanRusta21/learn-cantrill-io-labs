provider "aws" {
  region = "us-east-2"
  profile = "default"
}

module "sns" {
  source = "./sns"
  sns_topic_name = var.sns_topic_name
  email_address = var.email_address
}

module "lambda" {
  source = "./lambda"
  lambda_function_name = var.lambda_function_name
  lambda_function_handler = var.lambda_function_handler
  lambda_function_runtime = var.lambda_function_runtime
  lambda_function_architecture = var.lambda_function_architecture
  lambda_function_filename = var.lambda_function_filename
  lambda_function_file_path = var.lambda_function_file_path
}

module "api_gateway" {
  source = "./api_gateway"
  api_name = var.api_name
  lambda_invoke_arn = module.lambda.lambda_invoke_arn
}

