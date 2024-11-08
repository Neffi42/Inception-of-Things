#!/bin/sh

echo " * Creating a k3d cluster"
k3d cluster create mycluster

echo " * Installing Argo CD"
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo " * Setting 'argocd' as default namespace"
kubectl config set-context --current --namespace=argocd

echo " * Waiting for argocd to come online"
sleep 160

echo " * Configuring Argo CD to communicate with k3d"
argocd login --core

echo " * Installing Will's app"
kubectl create ns dev
argocd app create will-playground --repo https://github.com/Neffi42/iot-acroue --path . --dest-server https://kubernetes.default.svc --sync-policy automated --dest-namespace dev

echo " * Setting back 'default' as default namespace"
kubectl config set-context --current --namespace=default

echo "Applications successfully deployed"

echo " - Argo CD password:"
argocd admin initial-password -n argocd
