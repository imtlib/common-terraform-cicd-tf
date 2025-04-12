# common-terraform-cicd-tf

## 使い方

### Terraform フォーマッター実行

```bash
terraform fmt -recursive
```

### ユーザーID取得コマンド

```bash
aws sts get-caller-identity --profile { プロファイル名 } | jq --raw-output .UserId
```

## CICD パイプライン作成コマンド

### prod

```bash
terraform plan -var "aws_profile=AdministratorAccess-767398075406"
```

### test

```bash
terraform apply -var "aws_profile=AdministratorAccess-851725239804"
```

## Backend S3 作成コマンド

### prod

```bash
terraform apply -var "aws_profile=AdministratorAccess-767398075406"
```

### test

```bash
terraform apply -var "aws_profile=AdministratorAccess-851725239804"
```