output "api-return-ip-lambda-arn" {
  value = aws_lambda_function.api-return-ip.arn
}

output "api-return-ip-lambda-invoke-arn" {
  value = aws_lambda_function.api-return-ip.invoke_arn
}
