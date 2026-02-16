FROM node:20-alpine

WORKDIR /app

# Dependências úteis (git é comum em CLIs que fazem bootstrap)
RUN apk add --no-cache git bash curl

# Copia tudo
COPY . .

# Instala deps do projeto
RUN npm ci || npm install

# Porta do dashboard/SSE (vamos ajustar depois se o AIOS usar outra)
EXPOSE 3000

# Diretório de dados persistentes (vamos montar volume nele no EasyPanel)
RUN mkdir -p /data

# Start: por enquanto, deixamos como "help" para validar build.
# No próximo passo a gente troca para o comando real do servidor/dashboard.
CMD ["sh", "-c", "node -v && npx aios-core --help && tail -f /dev/null"]
