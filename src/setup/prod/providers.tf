provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      Environment    = var.prefix
      Owner          = var.owner
      Application    = var.application_name
      RepositoryName = "common-terraform-cicd-tf"
      ProductName    = "common"
      Team           = "common"
    }
  }
}
