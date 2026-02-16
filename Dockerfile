FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git bash curl

# Instala o CLI globalmente para disponibilizar o binário "aios"
RUN npm install -g aios-core@latest

# Copia seu fork (para podermos buscar configs/workers/templates, se houver)
COPY . .

# Porta padrão (vamos confirmar no próximo passo qual é a real)
EXPOSE 3000

RUN mkdir -p /data

# Mantém o container vivo por enquanto; no próximo passo trocamos para o comando do servidor/dashboard
CMD ["sh", "-c", "aios --version && aios --help && tail -f /dev/null"]
