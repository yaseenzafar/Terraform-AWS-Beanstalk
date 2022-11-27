resource "aws_cloudwatch_metric_alarm" "beanstalkalarm" {
  alarm_name                = "beanstalk-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions       =  aws_sns_topic_subscription.email_notification.topic_arn 
  ok_actions          =  aws_sns_topic_subscription.email_notification.topic_arn
  
}