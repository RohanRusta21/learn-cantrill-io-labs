provider "aws" {
  region = "us-east-2"
  profile = "default"
}

resource "aws_sns_topic" "my_sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "my_sns_topic_subscription" {
  topic_arn = aws_sns_topic.my_sns_topic.arn
  protocol  = "email"
  endpoint  = var.email_address
}


