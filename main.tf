#----------------- Create elastic beanstalk application --------------#
 
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = wordpressapp
}

#---------------- Create elastic beanstalk environment --------------#

resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = wordpressappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.1 running PHP 8.1"
  tier                = WebServer

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     =  "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     =  "True"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  
  setting {
    namespace = "aws:autoscaling:asg"                                            #For High Availability
    name      = "Availability Zones"
    value     = "Any 2"
    
  }
 
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
 
}

#----------------- Setting up Load Balancer ---------------# 

  setting { 
    namespace = "aws:elbv2:listener:default"
    name      = "ListenerEnabled"
    value     = false
    }
    
  setting {
      namespace = "aws:elbv2:listener:443"
      name      = "ListenerEnabled"
      value     = true
  }
  setting {
      namespace = "aws:elbv2:listener:443"
      name      = "Protocol"
      value     = "HTTPS"
   }
  setting {
      namespace = "aws:elbv2:listener:443"
      name      = "SSLCertificateArns"
      value     = certificatearnname
  }
  setting {
      namespace = "aws:elbv2:listener:443"
      name      = "SSLPolicy"
      value     = "ELBSecurityPolicy-2016-08"
    
  }
  setting {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "HealthCheckPath"
      value     = "/"
  }
  setting {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Port"
      value     = 80
  }
  setting {
      namespace = "aws:elasticbeanstalk:environment:process:default"
      name      = "Protocol"
      value     = "HTTP"
  }

#---------------- Trigger as per High CPU Utilization --------------#

setting {
    namespace = "aws:autoscaling:trigger"
    name      = "MeasureName"
    value     = "CPUUtilization"
    
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Statistic"
    value     = "Average"
    
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "Unit"
    value     = "Percent"
    
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerThreshold"
    value     = 70
    
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "LowerBreachScaleIncrement"
    value     = -1
    
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperThreshold"
    value     = 80
    
  }

  setting {
    namespace = "aws:autoscaling:trigger"
    name      = "UpperBreachScaleIncrement"
    value     = 1
    
  }

#--------------------- Redirection of traffic from port 80 to 443 ----------------------#

  resource "aws_lb_listener" "https_redirect" {
  load_balancer_arn = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

data "aws_lb" "eb_lb" {
  arn = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
}

resource "aws_security_group_rule" "allow_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = tolist(data.aws_lb.eb_lb.security_groups)[0]
}


  
  
