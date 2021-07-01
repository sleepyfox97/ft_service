#!/bin/sh

# stop each service if they exists
kubectl delete -f ./metallb/metallb.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl delete -f ./nginx/nginx.yaml
kubectl delete -f ./phpmyadmin/phpmyadmin.yaml
kubectl delete -f ./mysql/mysql.yaml
kubectl delete -f ./mysql/mysql-pv.yaml
kubectl delete -f ./wordpress/wordpress.yaml
kubectl delete -f ./ftps/ftps.yaml
kubectl delete -f ./ftps/ftps-pv.yaml 
kubectl delete -f ./influxdb/influx.yaml
kubectl delete -f ./influxdb/influx-pv.yaml
kubectl delete -f ./grafana/grafana.yaml

#docker build -t baseimg ./baseimg/.
docker build -t my-nginx ./nginx/.
docker build -t my-phpadmin ./phpmyadmin/.
docker build -t my-mysql ./mysql/.
docker build -t my-wordpress ./wordpress/.
docker build -t my-ftps ./ftps/.
docker build -t my-grafana ./grafana/.
docker build -t my-influxdb ./influxdb/.

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
kubectl apply -f ./wordpress/wordpress.yaml
kubectl apply -f ./ftps/ftps.yaml
kubectl apply -f ./ftps/ftps-pv.yaml

if [ ! -d "data/ftp-user" ]; then
	sudo mkdir -p /data/ftp-user
	sudo chmod 777 /data/ftp-user
fi

kubectl apply -f ./ftps/ftps-pv.yaml

kubectl apply -f ./influxdb/influxdb.yaml
kubectl apply -f ./influxdb/influxdb-pv.yaml
kubectl apply -f ./grafana/grafana.yaml
