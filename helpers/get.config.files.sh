#!/usr/bin/env bash

terraform output -raw talosconfig > talosconfig
terraform output -raw kubeconfig > kubeconfig
talosctl --talosconfig=talosconfig -e 172.16.200.10 -n 172.16.200.10 dmesg
kubectl get nodes --kubeconfig=kubeconfig

exit 0