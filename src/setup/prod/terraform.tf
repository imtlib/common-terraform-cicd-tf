terraform {
  # TODO: Terraform はできるだけ最新の安定バージョンを指定してください。
  required_version = "~> 1.11.0"
  required_providers {
    aws = {
      # TODO: AWS Provider はできるだけ最新のバージョンをしてください。
      version = "~> 5.94.0"
      source  = "hashicorp/aws"
    }
  }
}