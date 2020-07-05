#!/usr/bin/env bash

if [ -z "${etcd_endpoints}" ];then echo "Please set 'etcd_endpoints' var"; exit 1; fi

filename=etcd

if [ -f ${CERT_DIR:-/opt/k8s}/certs/etcd-client.pem ];then
  filename=etcd-client
fi

exec etcdctl \
--endpoints=${etcd_endpoints} \
--cacert=${CERT_DIR:-/opt/k8s}/certs/etcd-ca.pem \
--cert=${CERT_DIR:-/opt/k8s}/certs/${filename}.pem \
--key=${CERT_DIR:-/opt/k8s}/certs/${filename}-key.pem \
"$@"
