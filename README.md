Projeto DevOps:

Objetivos:
Criar toda a estrutura com o terraform, incluindo o ECR para hospedar a imagem da aplicação, através da Pipe IaC no Git.
 - Repo com os artefatos disponibilizados para a equipe de Finops/Engenharia.
Criar o fluxo de Deploy para o ArgoCd sendo o Git a única fonte de verdade.
 - Repo com os artefatos disponibilizados para a equipe de DevOps.
Criar o fluxo de Deploy para a Aplicação.
 - Repo com os artefatos disponibilizados para a equipe de Sustentação.

Etapas:

1 - Provisionamento da uma VM com o KVM (novo ambiente apenas com as configurações necessárias para evitar conflitos): (Finalizado)
virt-install --name=devops \
             --arch=x86_64 --vcpus=2 \
             --ram=6144 \
             --os-variant=fedora36 \
             --hvm \
             --connect=qemu:///system \
             --network bridge=br0 \
             --cdrom=/opt/kvm/image/fedora.iso \
             --disk path=/opt/kvm/disk/node5.qcow2,size=10 \
             --graphics vnc,keymap=pt-br \
             --noautoconsole

2 - Instalação configuração do Git, com repositório local sincronizado com o Github através de chaves SSH. (Finalizado)

3 - Instalaçao das dependências da aplicação e inicialização da mesma: (Finalizado)
pip install -r requirements.txt
gunicorn --log-level debug api:app

Teste local da aplicação realizado com sucesso:
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"first post!","content_id":1}'
*   Trying 127.0.0.1:8000...
* Connected to localhost (127.0.0.1) port 8000 (#0)
> POST /api/comment/new HTTP/1.1
> Host: localhost:8000
> User-Agent: curl/7.82.0
> Accept: */*
> Content-Type: application/json
> Content-Length: 68
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: gunicorn/20.0.4
< Date: Tue, 24 Sep 2024 22:18:42 GMT
< Connection: close
< Content-Type: application/json
< Content-Length: 92
< 
{
  "message": "comment created and associated with content_id 1", 
  "status": "SUCCESS"
}
* Closing connection 0

Obs.: No final desta etapa os repositórios (local e remoto) já se encontram sincronizados

4 - Adaptação da Documentação da Hashicorp/Terraform para EKS: (Finalizado)
https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks 

- Instalação, configuração e teste com sucesso do Terraform
- Instalação, configuração e teste com sucesso da CLI para interação na AWS
- Adaptação para a criação do ECR, que vai hospedar a imagem da Aplicação

5 - CI CD com Git (Finalizado)

Pipe IaC
Configuração da comunicação Git e AWS -> OpenId Connect Manualmente (Segurança)

Pipe Iac criando ArgoCd e Jaeger
Pipe da Aplicação

6 - ArgoCD  (Falta)
Configuração e Deploy da Aplicação

8 - Metricas/Jaeger (Entrega cancelada)
Métricas

9 - Futuras funcionalidades:
Configuração segura do "arquivo de estado" do terraform (terraform.tfstate), em um Bucket S3, para execução de pipes remotas e efetivas.
Botões de Pipes Automatizados.

10 - Lições aprendidas / Questionamentos:

- Em quatro dias parciais, minha maior dificuldade foi nas integrações, principalmente entre AWS e Git. Fiz uso do recurso de IA, porém, mesmo elaborando as questões de forma explícita e não genérica, o entendimento dos logs, me ajudou mais do que as informações trazidas pela IA, reforçando a idéia, que a IA necessita ser treinada da forma correta, e não necessariamente o ChatGPT por ter uma base de dados gigante como o Google seja tão efetivo assim.
- Na construção da Infra, aproximadamente 12 min, a construção do Cluster EKS aconteceu com sucesso, em aproximadamente 10 min, porém a falha aconteceu na implementação do recurso de Observabilidade, em menos de 2 min. Nem sempre automatizar todos os recursos em um única esteira, é efetivo.

