# ArgoCD

## Installing ArgoCD

### Create the namespace

```
kubectl create namespace argocd
```

### Create the values file

```yaml

global:
  logging:
    format: json

configs:
  cm:
    exec.enabled: true
    statusbadge.enabled: true
  params:
    server.insecure: true

notifications:
  enabled: false
```

### Install the helm chart

```
helm install argocd argo/argo-cd --values argocd-values.yaml --namespace argocd
```

## Access

### Admin initial password

Can be retrieved with 

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

### UI access

Open the local port with 

```
kubectl port-forward service/argocd-server -n argocd 8080:443
```
