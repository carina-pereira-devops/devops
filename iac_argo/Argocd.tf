####################################  ARGOCD ####################################

## Namespace
#resource "kubernetes_namespace" "argocd" {
#  metadata {
#    name = "argocd"
#  }
#}

# Implementação do Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "6.7.11"
  timeout    = "1500"
  namespace  = "argocd"
  values = [
    file("./argocd/install.yaml")
  ]
}

## Resgatando credenciais, e enviando para a pasta iac_argo (.txt no gitignore)
#resource "null_resource" "password" {
#  provisioner "local-exec" {
#    working_dir = "./argocd"
#    command     = "kubectl -n argocd-staging get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d > argocd-login.txt"
#  }
#}
#
## Deletando credenciais
#resource "null_resource" "del-argo-pass" {
#  depends_on = [null_resource.password]
#  provisioner "local-exec" {
#    command = "kubectl -n argocd-staging delete secret argocd-initial-admin-secret"
#  }
#}
#
