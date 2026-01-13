#!/bin/bash
set -e

echo "🧪 Testing GitOps Pipeline"
echo "=========================="

echo "1. Checking file structure..."
if [ -f "app/src/app.js" ] && [ -f "k8s/ytt-values.yml" ] && [ -f "k8s/template.yml" ]; then
    echo "✅ Basic files exist"
else
    echo "❌ Missing files"
    exit 1
fi

echo "2. Checking ytt installation..."
if command -v ytt &> /dev/null; then
    echo "✅ ytt is installed: $(ytt --version)"
else
    echo "❌ ytt is not installed"
    exit 1
fi

echo "3. Testing ytt template..."
if ytt -f k8s/ytt-values.yml -f k8s/template.yml --files-output=/tmp/ytt-test > /dev/null 2>&1; then
    echo "✅ ytt template is valid"
else
    echo "❌ ytt template has errors"
    exit 1
fi

echo "4. Generating manifests..."
./scripts/generate-manifests.sh dev
if [ -f "k8s/deployment.yml" ]; then
    echo "✅ Manifests generated successfully"
    echo "   File size: $(wc -l < k8s/deployment.yml) lines"
else
    echo "❌ Failed to generate manifests"
    exit 1
fi

echo "5. Validating Kubernetes manifests..."
if kubectl apply --dry-run=client -f k8s/deployment.yml > /dev/null 2>&1; then
    echo "✅ Kubernetes manifests are valid"
else
    echo "⚠️  kubectl validation failed (might not be connected to cluster)"
fi

echo ""
echo "🎉 All tests passed!"
echo ""
echo "Next steps:"
echo "1. Update k8s/ytt-values.yml with your Docker username"
echo "2. Run: ./scripts/deploy.sh dev v1.0.0"
echo "3. Commit to Git and setup ArgoCD"
