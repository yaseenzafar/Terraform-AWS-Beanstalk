resource "aws_sns_topic" "beanstalknotificationtopic" {
  name = "beanstalk_notification_topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = "aws_sns_topic.beanstalknotificationtopic.name"
  protocol  = "email"
  endpoint  = "yaseenzafar@hotmail.com"
}

#After this you have to manually accept subscription through your email inbox for subscription activation"