#Pornirea unui cluster minikube cu 3 noduri, 4GB RAM și 2 CPU pentru fiecare nod
minikube start --nodes 3 --memory=4g --cpus=2

#Stergerea clusterului minikube
minikube delete

#Rularea unui container interactiv folosind imaginea alpine
kubectl run -it --rm alpine --image=alpine

#Crearea unui namespace numit lab6
kubectl create namespace lab6

#Rularea unui container folosind imaginea alpine
kubectl run alpine --image=alpine -n lab6 --restart=Never --command -- sleep infinity
kubectl exec -it alpine -n lab6 -- sh

#Vizualizarea pod-urilor din namespace-ul lab6
kubectl get pods -n lab6

#Crearea unui pod folosind un fisier de configurare YAML
kubectl apply -f nginxpod.yaml

#Generarea unui fisier de configurare YAML pentru un pod folosind comanda kubectl run
kubectl run nginx --image=nginx --dry-run=client -o yaml > nginxpod_generat.yaml

#Vizualizarea pod-urilor care au label-ul app=myapp
kubectl get pods -l app=myapp

#Crearea unui replicaset folosind un fisier de configurare YAML
kubectl apply -f replicaset.yaml

#Stergerea tuturor pod-urilor din cluster
kubectl delete --all pods

#Stergerea replicaset-ului creat anterior
kubectl delete replicasetnginx-replicaset

#Crearea unui deployment folosind un fisier de configurare YAML
kubectl apply -f deployment.yaml

#Vizualizarea istoricului deployment-urilor
kubectl rollout history deployment nginx-deployment --revision=1

#Revenirea la o versiune anterioara a deployment-ului
kubectl rollout undo deployment nginx-deployment --to-revision=1

#Crearea unui configmap folosind un fisier de configurare YAML
kubectl apply -f configmap.yaml

#Crearea unui pod care utilizeaza configmap-ul creat anterior
kubectl apply -f configmap_demo_pod.yaml

#Vizualizarea continutului configmap-ului in interiorul pod-ului
kubectl exec -it configmap-demo-pod -- sh
#env