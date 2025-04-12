# ------- AWS の基本設定 -------
variable "aws_region" {
  type = string
}

# ------- Terraform の基本設定 -------
variable "prefix" {
  type = string
}

variable "application_name" {
  type = string
}

# ------- CodeBuild の設定値 -------
variable "codepipeline_bucket_id" {
  type = string
}