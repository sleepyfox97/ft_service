#!/bin/sh

# stop each service if they exists
kubectl delete -f ./metallb/metallb.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl delete -f ./nginx/nginx.yaml
kubectl delete -f ./phpmyadmin/phpmyadmin.yaml
kubectl delete -f ./mysql/mysql.yaml
kubectl delete -f ./mysql/mysql-pv.yaml

# build docker image of nginx

#docker build -t baseimg ./baseimg/.

docker build -t my-nginx ./nginx/.
docker build -t my-phpadmin ./phpmyadmin/.
docker build -t my-mysql ./mysql/.
docker build -t my-wordpress ./wordpress/.
# install metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# from manufest file, make resource
kubectl apply -f ./metallb/metallb.yaml
kubectl apply -f ./nginx/nginx.yaml
kubectl apply -f ./phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./mysql/mysql-pv.yaml
kubectl apply -f ./mysql/mysql.yaml
