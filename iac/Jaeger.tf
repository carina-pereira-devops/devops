#Criação Jaeger
resource "helm_release" "jaeger" {
  name             = "jaeger"
  chart            = "jaegertracing/jaeger"
  repository       = "https://jaegertracing.github.io/helm-charts"
  namespace        = "observability"          
  version          = "0.59.0"                 
  create_namespace = true                     # Criar o namespace se ele não existir
  depends_on       = [module.eks]             # Dependência para garantir que o cluster EKS esteja disponível antes de aplicar o release

  values = [
    <<EOF
collector:
  image:
    tag: "1.30"

query:
  image:
    tag: "1.30"
  service:
    type: LoadBalancer  # Ou ClusterIP, dependendo da necessidade de exposição
EOF
  ]
}
