provider "aws" {
  region = "us-east-1"
  #profile = "aws-b1-d1"
  profile = "specnet-tf-aug-vms"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnet" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name = "tag:Owner"
    values = ["VI"]
  }
}

# Local variable to filter out unwanted availability zones

module "eks_my" {
  source = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-tf"
  cluster_version = "1.28"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = data.aws_vpc.default.id
  subnet_ids               = data.aws_subnets.default_subnet.ids
  control_plane_subnet_ids = data.aws_subnets.default_subnet.ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

 /* access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::123456789012:role/something"

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = ["default"]
            type       = "namespace"
          }
        }
      }
    }
  }*/

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}