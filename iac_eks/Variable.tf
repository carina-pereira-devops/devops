# Adaptação do código da HashiCorp - Variáveis

# Como não façõ o filtro das regiões, eu declaro aqui a região explicitamente
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Repositório não é criado nesta etapa e sim com o código da aplicação
#variable "nome_repositorio" {
#  type        = string
#  default     = "devops-eks"
#}


