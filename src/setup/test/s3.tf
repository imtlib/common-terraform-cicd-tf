resource "aws_s3_bucket" "backend_s3" {
  for_each = toset(var.s3_bucket_names)
  bucket   = each.value
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "backend_s3" {
  for_each = aws_s3_bucket.backend_s3
  bucket   = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}