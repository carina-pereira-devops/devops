
terraform {

  required_version = ">= 1.0"

  required_providers {
    aws =  {
      region = "us-east-1"
    } 

    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }
}
