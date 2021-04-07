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