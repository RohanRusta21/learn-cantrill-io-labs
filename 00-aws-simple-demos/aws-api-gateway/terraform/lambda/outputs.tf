output "lambda_invoke_arn" {
  description = "The invocation ARN of the Lambda function"
  value       = aws_lambda_function.api-return-ip.invoke_arn
} 