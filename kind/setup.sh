#!/usr/bin/env bash
set -euo pipefail

echo "==> Criando cluster kind..."
kind create cluster --config cluster.yaml

echo "==> Aguardando cluster ficar pronto..."
kubectl wait --for=condition=Ready nodes --all --timeout=120s

echo "==> Fazendo deploy do Snake Classic..."
kubectl apply -f snake.yaml

echo "==> Aguardando pod ficar Running..."
kubectl wait --for=condition=Ready pod -l app=snake-classic --timeout=120s

echo ""
echo "✓ Tudo pronto! Acesse: http://localhost:8080"
echo ""
kubectl get pods,svc
