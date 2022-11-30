
Create file variables.tfvars

```text
  region = "eu-central-1"
  access_key = "..."
  secret_key = "..."
```

```text
terraform init -var-file=variables.tfvars
```
```text
terraform plan -var-file=variables.tfvars
```
```text
terraform apply -var-file=variables.tfvars
```
```text
terraform destroy -var-file=variables.tfvars
```

