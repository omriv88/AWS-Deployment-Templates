provider "aws" {
  region = "us-east-1"  
}

resource "aws_codecommit_repository" "demo_repo" {
  repository_name = "Demo_1"
  default_branch  = "main"
}

resource "aws_codecommit_notification_rule" "demo_notification_rule" {
  repository_name = aws_codecommit_repository.demo_repo.name
  name            = "DemoNotificationRole_1"
  events          = ["all"]
  target_arn      = aws_sns_topic.demo_sns_topic.arn
  target_type     = "SNS"
  target_address  = aws_sns_topic.demo_sns_topic.arn
}

resource "aws_sns_topic" "demo_sns_topic" {
  name = "DemoSnsTopic"
}

resource "aws_codecommit_trigger" "demo_trigger" {
  repository_name = aws_codecommit_repository.demo_repo.name
  trigger_name    = "DemoTrigger"
  events          = ["all"]
  branches        = ["main"]
  destination_arn = aws_sns_topic.demo_sns_topic.arn
  custom_data     = ""
}

output "codecommit_repository_url" {
  value = aws_codecommit_repository.demo_repo.clone_url_http
}
