#!/bin/sh

sudo sysctl fs.protected_regular=0

#eval $(minikube -p minikube docker-env)

# delete minikube status if run in your environmet
minikube delete

# start minikube on root
sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535

#change permission to use "minikube" and "kubectl" command
sudo chown -R $USER:$USER $HOME/.minikube
sudo chmod -R 755 $HOME/.minikube
sudo chown -R $USER:$USER $HOME/.kube
sudo chmod -R 755 $HOME/.kube
sudo chmod -R 777 /var/run/docker.sock

if [ ! -d "data/ftp-user" ]; then
        sudo mkdir -p /data/ftp-user
        sudo chmod 777 /data/ftp-user
fi

docker build -t my-nginx ./srcs/nginx/.
docker build -t my-phpadmin ./srcs/phpmyadmin/.
docker build -t my-mysql ./srcs/mysql/.
docker build -t my-wordpress ./srcs/wordpress/.
docker build -t my-ftps ./srcs/ftps/.
docker build -t my-grafana ./srcs/grafana/.
docker build -t my-influxdb ./srcs/influxdb/.

# install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# from manufest file, make resource
kubectl apply -f ./srcs/metallb/metallb.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/mysql/mysql-pv.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
kubectl apply -f ./srcs/ftps/ftps-pv.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/influxdb/influxdb-pv.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml

sudo minikube dashboard

