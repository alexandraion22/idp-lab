kubectl apply -f db-config-map.yaml
kubectl apply -f postgres-pv.yaml
kubectl apply -f postgres-pvc.yaml
kubectl apply -f db-pod.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f api-pod.yaml

#Expunerea serviciului API folosind un NodePort
kubectl expose pod api-pod --port=80 --type=NodePort

#Crearea unui serviciu pentru tunelarea traficului catre API
minikube service api-pod

#Pornirea unui terminal interactiv in interiorul pod-ului Postgres
kubectl exec -it db-pod -- sh