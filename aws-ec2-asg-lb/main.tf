terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

variable "name" {
  description = "Name of the EC2 instance"
  type = string
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_launch_template" "asg_config" {
    name          = "asg_config"
    image_id      = "ami-0c7217cdde317cfec"
    instance_type = "t2.micro"

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size = 8
        }
    }
    vpc_security_group_ids = [aws_security_group.allow_traffic.id]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "asg" {
    desired_capacity     = 2
    max_size             = 5
    min_size             = 1
    vpc_zone_identifier  = [aws_subnet.main.id]

    launch_template {
        id      = aws_launch_template.asg_config.id
        version = "$Latest"
    }

    tag {
        key                 = "Name"
        value               = "asg_instance"
        propagate_at_launch = true
    }
    target_group_arns = [ aws_lb_target_group.front_end.arn  ]
}

resource "aws_autoscaling_attachment" "asg_attachment" {
    autoscaling_group_name = aws_autoscaling_group.asg.id
    lb_target_group_arn = aws_lb_target_group.front_end.arn
}

# resource "aws_wafv2_web_acl" "example" {
#     name        = "example"
#     description = "Example of a managed rule"
#     scope       = "REGIONAL"

#     default_action {
#         allow {}
#     }

#     rule {
#         name     = "rule-1"
#         priority = 1

#         action {
#             block {}
#         }

#         statement {
#             managed_rule_group_statement {
#                 name        = "AWSManagedRulesCommonRuleSet"
#                 vendor_name = "AWS"
#                 version     = 1
#             }
#         }

#         visibility_config {
#             cloudwatch_metrics_enabled = false
#             metric_name                = "friendly-rule-metric-name"
#             sampled_requests_enabled   = false
#         }
#     }

#     visibility_config {
#         cloudwatch_metrics_enabled = false
#         metric_name                = "friendly-metric-name"
#         sampled_requests_enabled   = false
#     }

#     tags = {
#         Environment = "test"
#         Name        = "example"
#     }
# }

# resource "aws_wafv2_web_acl_association" "example" {
#     resource_arn = aws_lb.lb.arn
#     web_acl_arn  = aws_wafv2_web_acl.example.arn
# }