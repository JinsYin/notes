#!/bin/bash
# Author: JinsYin <jinsyin@gmail.com>

KUBECTL_VERSION="v1.6.2"

kube::check_permission()
{
  if [ $(id -u) -ne 0 ]; then
    echo "You must run as root user or through the sudo command."
    exit 1
  fi
}

kube::install_kubectl()
{
  kubectl > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    wget -O /tmp/k8s-client.tar.gz https://dl.k8s.io/$KUBECTL_VERSION/kubernetes-client-linux-amd64.tar.gz
    mkdir -p /tmp/k8s-client && tar -xzf /tmp/k8s-client.tar.gz -C /tmp/k8s-client --strip-components=1
    cp /tmp/k8s-client/client/bin/kube* /usr/local/sbin/
    chmod a+x /usr/local/sbin/kube*
  fi
}

kube::set_cluster()
{
  local KUBE_CLUSTER_NAME=$1
  local KUBE_APISERVER=$2
  kubectl config set-cluster kubernetes \
  --certificate-authority=/etc/kubernetes/ssl/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER}
}

kube::set_credentials()
{
  kubectl config set-credentials admin \
  --client-certificate=/etc/kubernetes/ssl/admin.pem \
  --embed-certs=true \
  --client-key=/etc/kubernetes/ssl/admin-key.pem
}

kube::set_context()
{
  kubectl config set-context kubernetes \
  --cluster=kubernetes \
  --user=admin
}

kube::use_context()
{
  kubectl config use-context kubernetes
}

main()
{
  kube::check_permission
  case $1 in
    "install")
      kube::install_kubectl
    ;;
    "config")
      shift
      kube::set_cluster $@
      kube::set_credentials
      kube::set_context
      kube::use_context
    *)
      echo "usage: $0 [install] | [config] "
      echo "       $0 master to install kubectl "
      echo "       $0 config to config kubectl "
      echo "       unkown command $0 $@" 
    ;;
  esac
}

main $@