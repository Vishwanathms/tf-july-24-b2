provider "aws" {
  alias = "dev"
  region = var.location
  #profile = "aws-b1-d1"
  profile = "specnet-tf-aug-vms"
}

locals {
  be_tf_path = var.backend_tf_apath
}

terraform {
  backend "s3" {
    #bucket         = "vishwa23082024"
    #key            =  "terraform-dev.tfstate" # This is the file path within the bucket
    #region         = "us-east-1"  # e.g., us-east-1
    #dynamodb_table = "terraform-locks"  # Optional, but recommended for state locking
    #encrypt        = true  # Encrypt state file at rest
    #profile = "specnet-tf-aug-vms"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

/*terraform {
  backend "azurerm" {
    resource_group_name   = "example-resources"  # Replace with your resource group
    storage_account_name  = "examplestorageacct" # Replace with your storage account name
    container_name        = "tfstate"            # Replace with your container name
    key                   = "terraform.tfstate"  # The name of the state file
  }
}*/



resource "aws_vpc" "main_dev" {
  provider = aws.dev
  cidr_block = var.cidr
  tags = {
    Name = var.tag_name
    owner = "vishwa"
    dep = "hr"
    env = var.env
  }

}
