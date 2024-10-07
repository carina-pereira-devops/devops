
terraform {

  required_providers {
    aws =  {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    } 

    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }
  }

}
