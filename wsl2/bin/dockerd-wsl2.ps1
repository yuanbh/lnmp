& $PSScriptRoot/../../kubernetes/wsl2/bin/kube-check.ps1

if(!$?){
  exit 1
}

wsl -d wsl-k8s -u root -- mkdir -p /wsl/wsl-k8s-data/docker

wsl -d wsl-k8s -- sh -c "cat /etc/default/docker | grep -q '\-\-host tcp://0.0.0.0:2375'"
wsl -d wsl-k8s -- sh -c "cat /etc/default/docker | grep -q '\-\-data\-root=/wsl/wsl-k8s-data/docker'"

if(!$?){
  "==> please check WSL [ /etc/default/docker ], see README.DOCKER.md"

  exit 1
}

Function _start(){
  wsl -d wsl-k8s -u root -- service docker start

  $ErrorActionPreference="continue"

  & $PSScriptRoot/wsl2hostd.ps1 stop

  & $PSScriptRoot/wsl2hostd.ps1 start
}

Function _stop(){
  wsl -d wsl-k8s -u root -- service docker stop
}

switch ($args[0]) {
  start {_start}
  stop {_stop}
  Default {
"
control Dockerd on WSL2

COMMAND:

start  Start Dockerd on WSL2
stop   Stop  Dockerd on WSL2
"
  }
}
