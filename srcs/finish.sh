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
kubectl delete -f ./influxdb/influxdb.yaml
kubectl delete -f ./influxdb/influxdb-pv.yaml
kubectl delete -f ./grafana/grafana.yaml

