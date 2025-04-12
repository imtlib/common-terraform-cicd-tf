output "codebuild_project_cicd_terraform_plan_name" {
  value = aws_codebuild_project.cicd_terraform_plan.name
}

output "codebuild_project_cicd_terraform_plan_arn" {
  value = aws_codebuild_project.cicd_terraform_plan.arn
}

output "codebuild_project_cicd_terraform_apply_name" {
  value = aws_codebuild_project.cicd_terraform_apply.name
}

output "codebuild_project_cicd_terraform_apply_arn" {
  value = aws_codebuild_project.cicd_terraform_apply.arn
}
