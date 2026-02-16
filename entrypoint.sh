#!/bin/bash
set -e

echo "=== AIOS Initialization ==="
echo "Version: $(aios --version)"
echo "Workspace: $AIOS_WORKSPACE"
echo "Log Dir: $AIOS_LOG_DIR"
echo "Cache Dir: $AIOS_CACHE_DIR"

# Valida instalação
aios validate --repair || true

echo "=== AIOS Ready ==="
echo "Container is running. You can call AIOS via:"
echo "  docker exec aios aios exec @analyst '...' --payload '{...}'"
echo "  or via n8n webhook integration"

# Mantém vivo
tail -f /dev/null
