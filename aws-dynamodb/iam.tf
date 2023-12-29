resource "aws_iam_role" "dax_role" {
    name = "db_dax_role"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "dax.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "dax_policy" {
    name = "db_dax_policy"
    role = aws_iam_role.dax_role.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:*",
                "dax:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}