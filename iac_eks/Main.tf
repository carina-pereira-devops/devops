# Adaptação código HashiCorp - Configurações dos Recursos da AWS

# Provider AWS
provider "aws" {
  region = var.region
}

# Resgatando informações do nome do cluster
locals {
  cluster_name = "devops-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

# Criando VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "devops-vpc"

  cidr = "10.0.0.0/16"

# Redundância em duas Zonas de Disponibilidade
  azs             = ["us-east-1a", "us-east-1b"]

# Sub-Redes
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  
# Tags, identificação importante para coleta de informações
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

# Criando o Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = "1.29"

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    devops = {
      min_size     = 1
      max_size     = 3
      desired_size = 2
      instance_types = ["t2.micro"]
    }
  }
}