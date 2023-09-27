## 1. Create the ServiceAccount named api-access in a new namespace called apps.

## Muschko, Benjamin. Certified Kubernetes Administrator (CKA) Study Guide (p. 78). O'Reilly Media. Kindle Edition. 
.PHONY: minikube-start create-namespace create-service-account-kubectl create-service-account-config delete-service-account get-service-account describe-service-account create-cluster-role get-roles describe-cluster-role get-role-bindings describe-role-binding create-pods create-pod-kubectl open-shell curl-list-pods

minikube-start:
	minikube start

create-namespace:
	kubectl create namespace apps

create-sa-secret:
	kubectl create -f sa-secret.yaml
	
create-service-account-kubectl:
	kubectl create serviceaccount api-access -n apps

create-service-account-config:
	kubectl create -f service-account.yaml

delete-service-account:
	kubectl delete serviceaccount api-access -n apps

get-service-account:
	kubectl get serviceaccounts -n apps

describe-service-account:
	kubectl describe serviceaccount api-access -n apps

## 2. Create a ClusterRole with the name api-clusterrole, 
# and create a ClusterRoleBinding named api-clusterrolebinding. 
# Map the ServiceAccount from the previous step to the API resources pods 
# with the operations watch, list, and get.

create-cluster-role:
	kubectl create -f cluster-role.yaml

get-roles:
	kubectl get clusterroles

describe-cluster-role:
	kubectl describe clusterrole api-clusterrole

get-role-bindings:
	kubectl get clusterrolebindings

describe-role-binding:
	kubectl describe clusterrolebinding api-clusterrolebinding

## Create a Pod named operator with the image nginx:1.21.1 
# in the namespace apps. Expose the container port 80. 
# Assign the ServiceAccount api-access to the Pod. 
# Create another Pod named disposable with the image nginx:1.21.1 
# in the namespace rm. 
# Do not assign the ServiceAccount to the Pod.

create-pods:
	kubectl create -f pods.yaml

create-pod-kubectl:
	kubectl run operator --image=nginx:1.21.1 --restart=Never \
  --port=80 --serviceaccount=api-access -n apps
 
# Open an interactive shell to the Pod named operator. 
# Use the command-line tool curl to make an API call to list the Pods
# in the namespace namespace rm. 
# What response do you expect? 
# Use the command-line tool curl to make an API call to delete the Pod
# disposable in the namespace rm. 
# Does the response differ from the first call? 
#You can find information about how to interact with Pods 
# using the API via HTTP in the reference guide.


get-service-account-token:
	export TOKEN=$(kubectl get secret service-account-api-access -n apps -o jsonpath='{.data.token}' | base64 --decode)
	kubectl get secret service-account-api-access -n apps -o jsonpath='{.data.token}' | base64 --decode

get-cluster-server:
	kubectl config view --minify -o \
    jsonpath='{.clusters[0].cluster.server}'
open-shell:
	kubectl exec -it operator -n apps -- /bin/bash

curl-list-pods:
	kubectl exec -it operator -n apps -- curl -X GET https://127.0.0.1:52821/api/v1/namespaces/rm/pods --header \
	"Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImRnSW95NzVqYkRfdmJYeHpFUHlLQnpmRlJlOXV1TG1feXNUZ29WOERPd3MifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJhcHBzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6InNlcnZpY2UtYWNjb3VudC1hcGktYWNjZXNzIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFwaS1hY2Nlc3MiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI4ZTUxYzI4OC1mOGFhLTRhOTAtYmM3OC1mZmY1OWEzZGY3ZTIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6YXBwczphcGktYWNjZXNzIn0.YawCryifVxjWGfeiSLnKaB7d--kfiZibo-UnQQsk525xRbGgbPyFsxkcJ5crAYeVRyUhB1jXKnNI48jEUSf0FMgAP-FBH7h2IKw9G_Rc_nVBiG2RLF1Vilo7uOV3pseR9dig6MHWNA_OcHOQAgUEU1hz-u6_SU3bB6jKsf_Q8Ti7Pz-bRSZtMB5ghmLfOxCJiuOuZGCmDkbNTkbZP_ncYT0YbsV4qwLVA8QhRZxifXKptkTaLMjH66NO-IwgPqboDHnxoxKk_CpTW0S4zw767hZ6RPnDUDDKbcro-iWzlxn7zWQzxR1WX65H7YGEc0Dy0kCFC5UAp1wykSrgHkpxLg" \
	--insecure