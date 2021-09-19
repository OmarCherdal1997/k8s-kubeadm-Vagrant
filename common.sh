#!/bin/bash

########################Functions
setnetwork(){
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
}

installComponent(){
    sudo apt-get update -qq
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common net-tools telnet  sshpass
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update -qq
    apt-cache policy docker-ce
    sudo apt-get install -y docker-ce kubelet kubeadm kubectl
    sudo apt-mark hold kubelet kubeadm kubectl 
    #sudo usermod -aG docker ${USER}
    sudo setfacl --modify user:${USER}:rw /var/run/docker.sock

}
installKubectl(){
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}
########################Main

setnetwork
installComponent
#installKubectl