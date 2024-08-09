## Exploring the variables

passing vlaues
* using cli 
* using terraform.tfvars
* using variable.tf file


# testing 

Changing the value of env to out of scope value, should give an error 

terraform plan -var location="us-west-1" -var cidr="10.10.0.0/16 -var env="uat"

## I was an different input file for different ENV
* created "dev'tfvars", "uat.tfvars"

## problem 
* the state file will get overqritten every time with diff input files.

## solution
* create worksapce 

  47 terraform workspace new dev
  48 terraform workspace new test
  49 terraform workspace new prod
  50 terraform workspace list
  51 terraform workspace select dev
  52 terraform workspace show
  53 terraform plan --var-file="../dev.tfvars" --out dev.plan
  54 terrform show --json .\dev.plan
  55 terrform show -json .\dev.plan
  56 terraform show -json .\dev.plan
  57 terraform show -json .\dev.plan > dev/dev.json
  