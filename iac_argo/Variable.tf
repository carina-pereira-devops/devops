# Validar se aqui referenciamos qual cluster EKS
variable "eks-name" {
  type    = string
  default = "devops-eks-hZbeMdvw" # validar
}

# Ainda não trabalhando efetivamente com ambiente no Argo?
variable "env" {
  default = "staging"
}
