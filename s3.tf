resource "aws_s3_bucket" "dev-bucket" {
  bucket   = "development-logs-bucket-11"
  provider = aws.dev

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = ["bucket"]
  }

}

