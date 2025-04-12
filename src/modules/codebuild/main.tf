resource "aws_codebuild_project" "cicd_terraform_plan" {
  name         = "${var.prefix}-${var.application_name}-plan-project"
  service_role = aws_iam_role.codebuild_tf_plan.arn

  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }

  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 0
    buildspec       = "buildspec.yml"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
}

resource "aws_codebuild_project" "cicd_terraform_apply" {
  name         = "${var.prefix}-${var.application_name}-apply-project"
  service_role = aws_iam_role.codebuild_tf_apply.arn

  artifacts {
    packaging = "NONE"
    type      = "CODEPIPELINE"
  }

  source {
    type            = "CODEPIPELINE"
    git_clone_depth = 0
    buildspec       = "buildspec.yml"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }
}
