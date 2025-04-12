resource "aws_iam_role" "codebuild_tf_plan" {
  name = "${var.prefix}-${var.application_name}-codebuild-tf-plan-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "sts:AssumeRole",
        Principal : {
          Service : "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_tf_plan" {
  name = "${var.prefix}-${var.application_name}-codebuild-tf-plan-role-policy"
  role = aws_iam_role.codebuild_tf_plan.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_role" "codebuild_tf_apply" {
  name = "${var.prefix}-${var.application_name}-codebuild-tf-apply-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : "sts:AssumeRole",
        Principal : {
          Service : "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_tf_apply" {
  name = "${var.prefix}-${var.application_name}-codebuild-tf-apply-role-policy"
  role = aws_iam_role.codebuild_tf_apply.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "*"
      }
    ]
  })
}