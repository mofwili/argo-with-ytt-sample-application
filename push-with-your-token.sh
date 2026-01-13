#!/bin/bash
set -e

echo "📤 Push to mofwili Repository"
echo "============================="

cd /home/simple-pipeline

echo "1. Setting up git remote..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/mofwili/argo-with-ytt-sample-application.git

echo "2. Creating commit..."
git add .
git commit -m "Complete GitOps pipeline with ytt and ArgoCD" 2>/dev/null || echo "No changes to commit"

echo "3. Pushing with token..."
echo ""
echo "Enter your Personal Access Token for mofwili repository:"
read -s token
echo ""

if [ -z "$token" ]; then
    echo "❌ No token provided"
    exit 1
fi

echo "Pushing to GitHub..."
git push https://mofwili:$token@github.com/mofwili/argo-with-ytt-sample-application.git main --force

# Clear token from memory
unset token

echo ""
echo "✅ Successfully pushed!"
echo "🔗 Repository: https://github.com/mofwili/argo-with-ytt-sample-application"
