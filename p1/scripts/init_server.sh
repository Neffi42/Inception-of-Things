#!/bin/sh

apt-get update
apt-get install -y curl

curl -sfL https://get.k3s.io | sh -

mkdir -p /vagrant/tmp
cp /var/lib/rancher/k3s/server/node-token /vagrant/tmp/node-token
