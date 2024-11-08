#!/bin/sh

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -

kubectl apply -f remote/confs
