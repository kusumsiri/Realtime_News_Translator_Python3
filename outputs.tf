# Output value definitions

output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."
  value = aws_s3_bucket.lambda_bucket.id
}

output "function_name" {
  description = "Name of the Lambda function."
  value = aws_lambda_function.news-translater.function_name
}

output "function_url" {
  description = "The Lambda function url"
  value = aws_lambda_function_url.function_url.function_url
}