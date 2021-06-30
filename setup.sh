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

# ./srcs/run.sh
