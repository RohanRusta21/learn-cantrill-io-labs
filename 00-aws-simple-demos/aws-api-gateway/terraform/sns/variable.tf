variable "sns_topic_name" {
  type = string
  description = "The name of the SNS topic"
  #default = "API-Messages"
}

variable "email_address" {
  type = string
  description = "The email address to send the SNS topic to"
  #default = "test@example.com"
}