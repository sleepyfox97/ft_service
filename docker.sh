#!/bin/sh

# start minikube on root
minikube start driver=docker
eval $(minikube docker-env)
#./srcs/dockerrun.sh
