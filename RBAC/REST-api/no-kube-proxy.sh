# docs: https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/
# Check all possible clusters, as your .KUBECONFIG may have multiple contexts:

kubectl config view -o jsonpath='{"Cluster name\tServer\n"}{range .clusters[*]}{.name}{"\t"}{.cluster.server}{"\n"}{end}'

# Select name of cluster you want to interact with from above output:
export CLUSTER_NAME="minikube"

# Point to the API server referring the cluster name
APISERVER=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$CLUSTER_NAME\")].cluster.server}")

# Create a secret to hold a token for the default service account
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: service-account-api-access
  namespace: apps
  annotations:
    kubernetes.io/service-account.name: api-access
type: kubernetes.io/service-account-token
EOF

# Wait for the token controller to populate the secret with a token:
while ! kubectl describe secret service-account-api-access -n apps | grep -E '^token' >/dev/null; do
    echo "waiting for token..." >&2
    sleep 1
done

# Get the token value
TOKEN=$(kubectl get secret service-account-api-access -n apps -o jsonpath='{.data.token}' | base64 --decode)

echo $TOKEN
echo $APISERVER

# Explore the API with TOKEN
curl -X GET $APISERVER/api --header "Authorization: Bearer $TOKEN" --insecure

kubectl exec -it operator -n apps -- curl -X GET $APISERVER/api --header "Authorization: Bearer $TOKEN" --insecure
