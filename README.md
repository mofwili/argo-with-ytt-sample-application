# Simple GitOps Pipeline

A minimal GitOps pipeline using ytt and ArgoCD.

## Quick Start
1. Update k8s/ytt-values.yml with your image
2. Generate manifests: ./scripts/generate-manifests.sh
3. Deploy with ArgoCD

## Structure
- app/: Application source code
- k8s/: Kubernetes manifests (ytt templates)
- argo/: ArgoCD configuration
- scripts/: Helper scripts
