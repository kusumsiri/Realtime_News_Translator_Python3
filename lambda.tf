resource "aws_lambda_function" "news-translater" {
  function_name = var.function_name

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_objects.key

  runtime = var.runtime
  handler = "news-translater.handler"

  role = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      NEWS_API_KEY = var.news_api_key
    }
  }
}

resource "aws_lambda_function_url" "function_url" {
  function_name      = aws_lambda_function.news-translater.function_name
  authorization_type = "NONE"
}

resource "aws_cloudwatch_log_group" "news-translater" {
  name = "/aws/lambda/${aws_lambda_function.news-translater.function_name}"

  retention_in_days = var.log_retention_in_days
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": ["sts:AssumeRole"],
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

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "translater_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/TranslateFullAccess"
}