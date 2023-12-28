resource "aws_cloudwatch_metric_alarm" "cpu_high" {
    alarm_name          = "cpu_high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUUtilization"
    namespace           = aws_appautoscaling_target.target.service_namespace
    period              = "60"
    statistic           = "Average"
    threshold           = "80"
    alarm_description   = "This metric triggers when CPU utilization is above 80% for 2 consecutive periods of 60 seconds."
    alarm_actions       = [aws_appautoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
    alarm_name          = "cpu_low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUUtilization"
    namespace           = aws_appautoscaling_target.target.service_namespace
    period              = "60"
    statistic           = "Average"
    threshold           = "20"
    alarm_description   = "This metric triggers when CPU utilization is below 20% for 2 consecutive periods of 60 seconds."
    alarm_actions       = [aws_appautoscaling_policy.scale_down.arn]
}