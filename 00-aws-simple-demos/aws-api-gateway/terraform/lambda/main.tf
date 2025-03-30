provider "aws" {
  region = "us-east-2"
  profile = "default"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda_function_file_path
  output_path = "lambda_function_payload.zip"
}


resource "aws_lambda_function" "api-return-ip" {
  function_name = var.lambda_function_name
  role = aws_iam_role.iam_for_lambda.arn
  handler = var.lambda_function_handler
  runtime = var.lambda_function_runtime
  filename = "lambda_function_payload.zip"
  architectures = var.lambda_function_architecture
  source_code_hash = data.archive_file.lambda.output_base64sha256
  ephemeral_storage {
    size = 512
  }
}






