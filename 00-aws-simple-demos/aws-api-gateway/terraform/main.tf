provider "aws" {
  region = "us-east-2"
  profile = "default"
}

module "sns" {
  source = "./sns"
  sns_topic_name = var.sns_topic_name
  email_address = var.email_address
}
