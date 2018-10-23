# keypr
1. Install minikube:

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.30.0/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube

2. Start kubernetes cluster

minikube start --network-plugin=cni --container-runtime=containerd  --kubernetes-version=v1.10.0 --memory=6000 --cpus=4

3. Start log-generator pod

kubectl apply -f log-generator.yml 

3. Create service and statefulset for elasticsearch

kubectl apply -f es-service.yaml

kubectl apply -f es-statefulset.yaml

if need expose elastic to nodeport

kubectl expose pod elasticsearch-logging-0 --type=NodePort  -n kube-system

kubectl get svc -n kube-system

kubectl port-forward elasticsearch-logging-0 9200:9200 -n kube-system

curl 127.0.0.1:9200/cluster-status

4. Create fluentd

kubectl apply -f fluentd-es-configmap.yaml

kubectl apply -f fluentd-es-ds.yaml

5. Create kibana

kubectl apply -f kibana-service.yaml

kubectl apply -f kibana-deployment.yaml

when kibana will be ready forward port:

kubectk get pod -n kube-system

kubectl port-forward  $(kubectl get pods -n kube-system | grep kibana | awk '{print $1}') 5601:5601 -n kube-system

6. Login to http://127.0.0.1:5601 and create index or see in logtrail