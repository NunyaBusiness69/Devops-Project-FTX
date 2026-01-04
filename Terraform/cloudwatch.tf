# CloudWatch CPU Alarm for Minecraft EC2
resource "aws_cloudwatch_metric_alarm" "minecraft_high_cpu" {
  alarm_name          = "minecraft-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "Alarm when EC2 CPU exceeds 90%"
  dimensions = {
    InstanceId = aws_instance.minecraft.id
  }
  alarm_actions = []
}
