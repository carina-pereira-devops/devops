# Onde utilizamos o nome do Cluster? Qual a definição na IaC do EKS para cluster?
variable "eks-name" {
  type    = string
  default = "my-cluster"
}

# Ainda não trabalhando efetivamente com ambiente no Argo?
variable "env" {
  default = "staging"
}

# Backend
variable "bucket_name" {
  type = string
}