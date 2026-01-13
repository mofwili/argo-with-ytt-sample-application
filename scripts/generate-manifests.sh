#!/bin/bash
echo "Generating manifests..."
ytt -f k8s/ytt-values.yml -f k8s/template.yml > k8s/deployment.yml
echo "✅ Generated k8s/deployment.yml"
