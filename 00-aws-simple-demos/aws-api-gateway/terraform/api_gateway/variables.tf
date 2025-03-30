variable "api_name" {
  type = string
  description = "The name of the API"
  #default = "My-Demo-API"
}

variable "lambda_invoke_arn" {
  type = string
  description = "The invocation ARN of the Lambda function"
}
