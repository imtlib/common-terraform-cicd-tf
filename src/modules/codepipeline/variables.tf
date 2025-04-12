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

# ------- Codepipeline の設定値 -------
variable "repository_name" {
  type = string
}

variable "branch_name" {
  type = string
}

variable "codepipeline_bucket_name" {
  type        = string
  description = "（Artifact管理用）S3 バケット名"
}

variable "codepipeline_bucket_arn" {
  type        = string
  description = "（Artifact管理用）S3 バケットのARN"
}

variable "codebuild_project_cicd_terraform_plan_name" {
  type        = string
  description = "CodeBuild の Plan Project の名前"
}

variable "codebuild_project_cicd_terraform_plan_arn" {
  type        = string
  description = "CodeBuild の Plan Project の ARN"
}

variable "codebuild_project_cicd_terraform_apply_name" {
  type        = string
  description = "CodeBuild の Apply Project の名前"
}

variable "codebuild_project_cicd_terraform_apply_arn" {
  type        = string
  description = "CodeBuild の Apply Project の ARN"
}