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

# ------- アプリケーション設定 -------
variable "applications" {
  type = list(object({
    name       = string
    repository = string
    branch     = string
  }))
  description = "デプロイするアプリケーションの設定リスト"
  default = [
    {
      name       = "smart-agent-tf"
      repository = "smart-agent-tf"
      branch     = "test"
    },
    {
      name       = "smart-agent-iam-tf"
      repository = "smart-agent-iam-tf"
      branch     = "test"
    }
  ]
}