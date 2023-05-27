variable "runtime" {
    description = "lambda function runtime env"
    type = string
    default = "Python 3.10"
}

variable "function_name" {
    description = "Provide name to the lambda function"
    type = string
    default = "news-translater"
}

variable "bucket_name" {
    description = "Provide the details of S3 Bucket where the lambda fuction code is stored"
    type = string
    default = "kusumsiri-test-bucket"
}

variable "log_retention_in_days" {
    description = "Provide the number of days for log to be available in cloudwatch for this lambda function"
    type = number
    default = 1
}

variable "news_api_key" {
    description = "The news api key"
    type = string
    sensitive = true
}

