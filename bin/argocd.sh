function install() {
  echo "Installing ArgoCD in $1"
  _version=$(yq -r '.chartVersion' ${REPO_ROOT}/argocd-config/$1/argocd-values.yaml)
  helm install argocd argo/argo-cd --version $_version \
  --values ${REPO_ROOT}/argocd-config/argocd-default-values.yaml \
  --values ${REPO_ROOT}/argocd-config/$1/argocd-values.yaml \
  --namespace argocd --create-namespace --kube-context $1
}

function upgrade() {
  echo "Upgrading ArgoCD from $1"
  _version=$(yq -r '.chartVersion' ${REPO_ROOT}/argocd-config/$1/argocd-values.yaml)
  helm upgrade argocd argo/argo-cd --version $_version \
  --values ${REPO_ROOT}/argocd-config/argocd-default-values.yaml \
  --values ${REPO_ROOT}/argocd-config/$1/argocd-values.yaml \
  --namespace argocd --kube-context $1
}

function uninstall() {
  echo "Removing ArgoCD from $1"
  helm uninstall argocd --namespace argocd --kube-context $1
}

function list() {
  helm list --namespace argocd --kube-context $1
}

REPO_ROOT=$(git rev-parse --show-toplevel)

for ctx in ${REPO_ROOT}/argocd-config/*; do
test -d $ctx && ${1:-list} $(basename $ctx)
done