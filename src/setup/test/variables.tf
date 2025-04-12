# ------- AWS の基本設定 -------
variable "aws_profile" {
  type        = string
  description = "Terraform の実行に使用する AWS プロファイル名"
  default     = null
}

variable "aws_region" {
  type        = string
  description = "リソースをデプロイする AWS リージョン"
  default     = "ap-northeast-1"
}

# ------- Terraform の基本設定 -------
variable "prefix" {
  type        = string
  description = "リソース名のプレフィックスや環境（例:prod, testなど）を示す文字列。"
  default     = "test"
}

variable "application_name" {
  type        = string
  description = "チームの Terraform の場合はチーム名、サービスの Terraform の場合はアプリケーション名。"
  default     = "common-terraform-cicd"
}

variable "owner" {
  type        = string
  description = "リソースの作成者または環境（例:prod, testなど）を示す文字列。"
  default     = "test"
}

# ------- Setup の基本設定 -------
variable "s3_bucket_names" {
  type        = list(string)
  description = "バックエンド S3 バケットの名前リスト"
  default = [
    "test-smart-agent-tf-state",
    "test-smart-agent-iam-tf-state"
  ]
}