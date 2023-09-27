.PHONY: minikube-start

minikube-start:
	minikube start

create-ingress-controller:
	kubectl create -f ingress-controller.yaml

get-pod-host:
	kubectl get pod ingress-controller -o yaml | yq e .status.hostIP

get-node:
	kubectl get pod ingress-controller -o yaml | yq .spec.nodeName >> node.txt

create-ns:
	kubectl create ns t012
	
kustomize-plan:
	kubectl kustomize ./kustomize

kustomize-apply:
	kubectl apply -k ./kustomize

kustomize-delete:
	kubectl delete -k ./kustomize

kubectl-apply:
	kubectl apply -f ./manifests -R

kubectl-delete:
	kubectl delete -f ./manifests -R

change-dir:
	yq eval '.data.dir = "/etc/logs/traffic.txt"' -i ./manifests/configmap.yaml

