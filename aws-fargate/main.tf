terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
}

variable repository_name{
    type = string
    description = "ECR repository name"
}
variable cluster_name{
    type = string
    description = "ECS cluster name"
}

data "aws_ecr_repository" "repository" {
    name = var.repository_name
}

resource "aws_ecs_cluster" "cluster" {
    name = var.cluster_name
}

resource "aws_ecs_task_definition" "task" {
    family                   = "my-task"
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = 256
    memory                   = 512
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

    container_definitions = jsonencode([{
        name  = "my-container"
        image = data.aws_ecr_repository.repository.repository_url
        cpu = 256
        memory = 512
        portMappings = [{
            containerPort = 80
            hostPort      = 80
            protocol      = "tcp"
        }]
    }])

    runtime_platform {
        operating_system_family = "LINUX"
        cpu_architecture        = "X86_64"
    }
}

resource "aws_ecs_service" "service" {
    name            = "my-service"
    cluster         = aws_ecs_cluster.cluster.id
    task_definition = aws_ecs_task_definition.task.arn
    launch_type     = "FARGATE"

    network_configuration {
        subnets = [aws_subnet.main.id] #
        assign_public_ip = true
    }

    desired_count = 1

    load_balancer {
        target_group_arn = aws_lb_target_group.lb_tg.arn
        container_name   = "my-container"
        container_port   = 80
    }

    depends_on = [aws_lb_listener.listener]
}

resource "aws_appautoscaling_target" "target" {
    max_capacity       = 5
    min_capacity       = 1
    resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_up" {
    name               = "scale_up"
    resource_id        = aws_appautoscaling_target.target.resource_id
    scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
    service_namespace  = aws_appautoscaling_target.target.service_namespace

    step_scaling_policy_configuration {
        adjustment_type         = "ChangeInCapacity"
        cooldown                = 300
        metric_aggregation_type = "Average"

        step_adjustment {
            metric_interval_lower_bound = 0
            scaling_adjustment          = 1
        }
    }
}

resource "aws_appautoscaling_policy" "scale_down" {
    name               = "scale_down"
    resource_id        = aws_appautoscaling_target.target.resource_id
    scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
    service_namespace  = aws_appautoscaling_target.target.service_namespace

    step_scaling_policy_configuration {
        adjustment_type         = "ChangeInCapacity"
        cooldown                = 300
        metric_aggregation_type = "Average"

        step_adjustment {
            metric_interval_upper_bound = 0
            scaling_adjustment          = -1
        }
    }
}