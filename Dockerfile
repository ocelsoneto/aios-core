FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git bash curl jq

# Instala CLI globalmente
RUN npm install -g aios-core@latest

# Copia seu fork
COPY . .

# Instala deps locais (se houver package.json com workers/templates customizados)
RUN npm ci --only=production 2>/dev/null || true

# Diretório de persistência (workspace, projetos, cache)
RUN mkdir -p /data /data/workspace /data/logs /data/cache

# Variáveis de ambiente padrão (vamos sobrescrever no EasyPanel)
ENV AIOS_WORKSPACE=/data/workspace \
    AIOS_LOG_DIR=/data/logs \
    AIOS_CACHE_DIR=/data/cache \
    NODE_ENV=production

# Health check (verifica se o CLI está disponível)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD aios --version || exit 1

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
CMD ["/app/entrypoint.sh"]
