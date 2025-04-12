resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket        = "${var.prefix}-${var.application_name}-github-artifact"
  force_destroy = true
}