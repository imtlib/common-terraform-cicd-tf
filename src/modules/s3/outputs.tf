output "codepipeline_bucket_name" {
  value = aws_s3_bucket.codepipeline_bucket.bucket
}

output "codepipeline_bucket_arn" {
  value = aws_s3_bucket.codepipeline_bucket.arn
}

output "codepipeline_bucket_id" {
  value = aws_s3_bucket.codepipeline_bucket.id
}