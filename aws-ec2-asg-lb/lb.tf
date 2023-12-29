resource "aws_lb" "lb" {
    name               = "loadBalancer"
    internal           = false
    load_balancer_type = "application"
    
    security_groups    = [aws_security_group.allow_traffic.id]
    subnets            = [aws_subnet.main.id, aws_subnet.secondary.id]

    access_logs {
        bucket  = aws_s3_bucket.lb_logs.bucket
        enabled = true
        prefix = "lb_logs"
    }

}


resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.lb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.front_end.arn
    }
}

resource "aws_lb_target_group" "front_end" {
    name     = "frontEnd"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.main.id
}