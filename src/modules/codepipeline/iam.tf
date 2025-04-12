resource "aws_iam_role" "codepipeline" {
  name = "${var.prefix}-${var.application_name}-codepipeline-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "sts:AssumeRole",
        Principal : {
          Service : "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline" {
  name = "${var.prefix}-${var.application_name}-codepipeline-role-policy"
  role = aws_iam_role.codepipeline.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Resource : aws_iam_role.codepipeline_source_stage.arn,
        Effect : "Allow"
      },
      {
        Action : "sts:AssumeRole",
        Resource : aws_iam_role.codepipeline_codebuild.arn,
        Effect : "Allow"
      }
    ]
  })
}

resource "aws_iam_role" "codepipeline_source_stage" {
  name = "${var.prefix}-${var.application_name}-codepipeline-source-stage-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : "sts:AssumeRole",
        Principal : {
          AWS : aws_iam_role.codepipeline.arn
        },
        Effect : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_source_stage" {
  name = "${var.prefix}-${var.application_name}-codepipeline-source-stage-role-policy"
  role = aws_iam_role.codepipeline_source_stage.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Action : [
          "s3:Get*",
          "s3:Put*"
        ],
        Resource : "${var.codepipeline_bucket_arn}/*",
        Effect : "Allow"
      },
      {
        Action : [
          "s3:ListBucket",
        ],
        Resource : var.codepipeline_bucket_arn,
        Effect : "Allow"
      },
      {
        Action : [
          "codestar-connections:UseConnection"
        ],
        Resource : "*",
        Effect : "Allow"
      }
    ]
  })
}

resource "aws_iam_role" "codepipeline_codebuild" {
  name = "${var.prefix}-${var.application_name}-codepipeline-codebuild-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "sts:AssumeRole",
        Principal : {
          AWS : aws_iam_role.codepipeline.arn
        },
      }
    ]
  })
}

resource "aws_iam_role_policy" "codepipeline_codebuild" {
  name = "${var.prefix}-${var.application_name}-codepipeline-codebuild-role-policy"
  role = aws_iam_role.codepipeline_codebuild.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:StopBuild"
        ],
        Resource : [
          var.codebuild_project_cicd_terraform_plan_arn,
          var.codebuild_project_cicd_terraform_apply_arn
        ]
      },
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogGroup"
        ],
        Resource : "*",
      }
    ]
  })
}