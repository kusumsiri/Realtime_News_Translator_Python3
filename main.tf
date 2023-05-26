resource "random_pet" "lambda_bucket_name" {
  prefix = "terraform-bucket"
  length = 4
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id  
  force_destroy = true
}

data "archive_file" "lambda_objects" {
  type = "zip"

  source_dir  = "${path.module}/lambda-functions"
  output_path = "${path.module}/lambda-functions.zip"
}

resource "aws_s3_object" "lambda_objects" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "lambda-functions.zip"
  source = data.archive_file.lambda_objects.output_path
}

