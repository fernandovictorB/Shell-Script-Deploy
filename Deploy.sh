#!/bin/bash

echo "Iniciando deploy..."

# Carregae variáveis do arquivo .env
if [ -f .env ]; then
    source .env
else
    echo "Erro: Arquivo .env não encontrado. Certifique-se de que ele está no mesmo diretório."
    exit 1 
fi

# Verificar se a variáveis foram carregadas 
if [ -z "$USUARIO_SERVIDOR" ] || [ -z "$IP_SERVIDOR" ] || [ -z "$DIRETORIO_ALVO" ]; then
    echo "Erro: Variáveis de ambiente não definidas corretamente no arquivo .env."
    exit 1 
fi

# Enviando arquivos para o servidor 
echo "Enviando arquivos para servidor apache"
ssh $USUARIO_SERVIDOR@$IP_SERVIDOR "mkdir -p $DIRETORIO_ALVO"
scp -r * $USUAIRO_SERVIDOR@$IP_SERVIDOR:$DIRETORIO_ALVO

echo "Reniciando servidor web..."
ssh $USUARIO_SERVIDOR@$IP_SERVIDOR "sudo systemctl restart apache2"

echo "Deploy concluído!"

