resource "aws_codepipeline" "codepipeline" {
  name          = "${var.prefix}-pl-${var.application_name}"
  pipeline_type = "V2"
  role_arn      = aws_iam_role.codepipeline.arn

  artifact_store {
    location = var.codepipeline_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      role_arn         = aws_iam_role.codepipeline_source_stage.arn

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "imtlib/${var.repository_name}"
        BranchName       = var.branch_name
        DetectChanges    = true
      }
    }
  }

  stage {
    name = "Plan"
    action {
      name             = var.codebuild_project_cicd_terraform_plan_name
      category         = "Test"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["plan_output"]
      role_arn         = aws_iam_role.codepipeline_codebuild.arn

      configuration = {
        ProjectName = var.codebuild_project_cicd_terraform_plan_name
        EnvironmentVariables = jsonencode(concat([
          {
            name  = "CODEPIPELINE_STAGE_NAME"
            value = "Plan"
            type  = "PLAINTEXT"
          },
          {
            name  = "PREFIX"
            value = var.prefix
            type  = "PLAINTEXT"
          },
          {
            name  = "TF_CMD"
            value = "plan"
            type  = "PLAINTEXT"
          },
          {
            name  = "TF_OPTION"
            value = "-input=false -no-color"
          }
        ]))
      }
    }
  }

  stage {
    name = "Build"
    action {
      name            = var.codebuild_project_cicd_terraform_apply_name
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["plan_output"]
      role_arn        = aws_iam_role.codepipeline_codebuild.arn

      configuration = {
        ProjectName = var.codebuild_project_cicd_terraform_apply_name
        EnvironmentVariables = jsonencode(concat([
          {
            name  = "CODEPIPELINE_STAGE_NAME"
            value = "Build"
            type  = "PLAINTEXT"
          },
          {
            name  = "PREFIX"
            value = var.prefix
            type  = "PLAINTEXT"
          },
          {
            name  = "TF_CMD"
            value = "apply"
            type  = "PLAINTEXT"
          },
          {
            name  = "TF_OPTION"
            value = "-input=false -no-color -auto-approve"
            type  = "PLAINTEXT"
          }
        ]))
      }
    }
  }
}

resource "aws_codestarconnections_connection" "github" {
  name          = "github-imtlib"
  provider_type = "GitHub"
}
