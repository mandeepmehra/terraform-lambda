resource "aws_lambda_function" "myfunc" {
  filename         = "lambda.py.zip"
  function_name    = "mylambdafunction"
  handler          = "lambdaHandler"
  source_code_hash = filebase64sha256("lambda.py.zip")
  role             = aws_iam_role.lambdarole.arn
  runtime          = "python3.8"
}

resource "aws_iam_role" "lambdarole" {
  name               = "basiclambdarole-mandeep"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_s3_bucket" "s3bucket" {
  bucket = "s3lambdatriggerexamplemandeep"
}

resource "aws_cloudwatch_log_group" "cwlogs" {
  name              = "/aws/lambda/mylambdafunction"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging_mandeep"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambdarole.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}