#!/bin/sh

minikube start driver=docker

# install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./metallb/metallb.yaml


eval $(minikube docker-env)

#docker build -t baseimg ./baseimg/.
docker build -t my-nginx ./nginx/.
docker build -t my-phpadmin ./phpmyadmin/.
docker build -t my-mysql ./mysql/.
docker build -t my-wordpress ./wordpress/.
docker build -t my-ftps ./ftps/.
docker build -t my-grafana ./grafana/.
docker build -t my-influxdb ./influxdb/.


# from manufest file, make resource
kubectl apply -f ./nginx/nginx.yaml
kubectl apply -f ./phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./mysql/mysql-pv.yaml
kubectl apply -f ./mysql/mysql.yaml
kubectl apply -f ./wordpress/wordpress.yaml
kubectl apply -f ./ftps/ftps.yaml
kubectl apply -f ./ftps/ftps-pv.yaml
kubectl apply -f ./ftps/ftps-pv.yaml
kubectl apply -f ./influxdb/influxdb.yaml
kubectl apply -f ./influxdb/influxdb-pv.yaml
kubectl apply -f ./grafana/grafana.yaml
