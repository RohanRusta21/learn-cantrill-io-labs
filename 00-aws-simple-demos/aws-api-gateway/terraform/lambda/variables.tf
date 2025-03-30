variable "lambda_function_name" {
  type = string
  description = "The name of the lambda function"
  #default = "api-return-ip"
}

variable "lambda_function_handler" {
  type = string
  description = "The handler of the lambda function"
  #default = "lambda_function.lambda_handler"
}

variable "lambda_function_runtime" {
  type = string
  description = "The runtime of the lambda function"
  #default = "python3.9"
}

variable "lambda_function_architecture" {
  type = list(string)
  description = "The architecture of the lambda function"
  #default = ["x86_64"]
}

variable "lambda_function_filename" {
  type = string
  description = "The filename of the lambda function"
  #default = "lambda_function.py"
}


variable "lambda_function_file_path" {
  type = string
  description = "The path to the lambda function file"
  #default = "lambda_function.py"
}
