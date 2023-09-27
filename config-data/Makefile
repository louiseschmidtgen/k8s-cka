## Muschko, Benjamin. Certified Kubernetes Administrator (CKA) Study Guide (p. 78). O'Reilly Media. Kindle Edition. 
.PHONY: minikube-start create-nginx

minikube-start:
	minikube start

create-nginx:
	kubectl create -f nginx.yaml

update-nginx-volumes:
	kubectl apply -f nginx.yaml
create-hpa-nginx:
	kubectl create -f nginx-hpa.yaml

scale-nginx:
	kubectl scale deployment nginx --replicas=7

update-nginx:
	kubectl set image deployment nginx nginx=nginx:1.21.1 --record

rollout-status:
	kubectl rollout status deployment nginx

rollout-history:
	kubectl rollout history deployment nginx

rollout-history-revision:
	kubectl rollout history deployment nginx

rollout-undo:	
	kubectl rollout undo deployment nginx --to-revision=1

create-secret:
	kubectl create -f secret.yaml