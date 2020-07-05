$NODE_NAME="windows"
$K8S_ROOT="c:\kubernetes"
$ip="192.168.199.100"

kubelet `
--node-ip=$ip `
--bootstrap-kubeconfig=${K8S_ROOT}/conf/kubelet-bootstrap.kubeconfig `
--cert-dir=${K8S_ROOT}/certs `
--root-dir=/var/lib/kubelet `
--kubeconfig=${K8S_ROOT}/conf/kubelet.kubeconfig `
--config=${PSScriptRoot}/etc/kubelet.config.yaml `
--hostname-override=${NODE_NAME} `
--volume-plugin-dir=${K8S_ROOT}/usr/libexec/kubernetes/kubelet-plugins/volume/exec/ `
--logtostderr=true `
--dynamic-config-dir=${K8S_ROOT}/var/lib/kubelet/dynamic-config `
--container-runtime=remote `
--container-runtime-endpoint=npipe:////./pipe/containerd-containerd `
--v=2

# --container-runtime=docker `
# --container-runtime-endpoint= `
# --cni-cache-dir=/opt/k8s/var/lib/cni/cache `
# --pod-infra-container-image=mcr.microsoft.com/oss/kubernetes/pause:1.3.0 `
# --image-pull-progress-deadline=20m `
# --network-plugin=cni `
# --cni-bin-dir="C:\\bin\\cni" `
# --cni-conf-dir=$PSScriptRoot\etc\cni `

# --container-runtime=remote `
# --container-runtime-endpoint=npipe:////./pipe/containerd-containerd `

# --windows-service `
