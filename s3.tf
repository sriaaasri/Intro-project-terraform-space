resource "aws_s3_bucket" "dev-bucket" {
  bucket   = "development-logs-bucket-11"
  provider = aws.dev
}

