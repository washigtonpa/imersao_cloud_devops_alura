# Use uma imagem oficial do Python como imagem base.
# A versão 3.11 é mais recente e a tag com a versão do Alpine (3.20) garante builds reprodutíveis.
FROM python:3.11-alpine3.20

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker
COPY requirements.txt .

# Instala as dependências
# A flag --no-cache-dir desabilita o cache do pip, reduzindo o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que o app será executado
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar
# Use 0.0.0.0 para tornar a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
