# Selecionando SO para aplicação com atualizações, desabilitando configurações com interatividade
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3.9 python3.9-dev pip

# Configurando diretório atual para o diretório /app a ser executado no container
WORKDIR /app

# Copiando artefatos
COPY . /app

# Instalando dependências
RUN pip install -r requirements.txt

# Expondo porta da aplicação
EXPOSE 8000

# Comando de Inicialização
CMD ["gunicorn", "--log-level" "debug api:app"]