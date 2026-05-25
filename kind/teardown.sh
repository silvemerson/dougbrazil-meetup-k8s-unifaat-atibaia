#!/usr/bin/env bash
set -euo pipefail

echo "==> Removendo cluster kind..."
kind delete cluster --name demo-k8s

echo "✓ Cluster removido."
