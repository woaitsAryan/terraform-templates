resource "aws_s3_bucket" "lb_logs" {
    bucket = "my-loadbalancer-logs12312"
}

resource "aws_s3_bucket_policy" "allow_access_from_vpc" {
  bucket = aws_s3_bucket.lb_logs.id
  policy = data.aws_iam_policy_document.allow_access_from_vpc.json
}

data "aws_iam_policy_document" "allow_access_from_vpc" {
    statement {
        sid    = "AllowVPCAccess"
        effect = "Allow"

        principals {
            type        = "*"
            identifiers = ["*"]
        }

        actions   = ["s3:*"]
        resources = ["arn:aws:s3:::my-loadbalancer-logs12312/*"]

        condition {
            test     = "StringEquals"
            variable = "aws:sourceVpc"

            values = [
                "${aws_vpc.main.id}"
            ]
        }
    }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = aws_vpc.main.id
  service_name = "com.amazonaws.us-east-1.s3"
}