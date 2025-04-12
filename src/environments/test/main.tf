/*==============
  Root file
===============*/

# ------- S3 -------
module "s3" {
  for_each = { for app in var.applications : app.name => app }
  source   = "../../modules/s3"

  prefix           = var.prefix
  application_name = each.value.name
}

# ------- CodeBuild -------
module "codebuild" {
  for_each = { for app in var.applications : app.name => app }
  source   = "../../modules/codebuild"

  aws_region       = var.aws_region
  prefix           = var.prefix
  application_name = each.value.name

  codepipeline_bucket_id = module.s3[each.key].codepipeline_bucket_id
}

# ------- CodePipeline -------
module "codepipeline" {
  for_each = { for app in var.applications : app.name => app }
  source   = "../../modules/codepipeline"

  aws_region       = var.aws_region
  prefix           = var.prefix
  application_name = each.value.name

  repository_name                             = each.value.repository
  branch_name                                 = each.value.branch
  codepipeline_bucket_name                    = module.s3[each.key].codepipeline_bucket_name
  codepipeline_bucket_arn                     = module.s3[each.key].codepipeline_bucket_arn
  codebuild_project_cicd_terraform_plan_name  = module.codebuild[each.key].codebuild_project_cicd_terraform_plan_name
  codebuild_project_cicd_terraform_plan_arn   = module.codebuild[each.key].codebuild_project_cicd_terraform_plan_arn
  codebuild_project_cicd_terraform_apply_name = module.codebuild[each.key].codebuild_project_cicd_terraform_apply_name
  codebuild_project_cicd_terraform_apply_arn  = module.codebuild[each.key].codebuild_project_cicd_terraform_apply_arn
}