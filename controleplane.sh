#!/bin/bash
######################## Variables

IP_MASTER=$(hostname -I | cut -d " " -f2)
######################## Functions
startKubeadm(){
    sudo kubeadm init
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
}
setnetworkadon() {
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
}

setSsh(){

sudo -u vagrant bash -c "ssh-keygen -b 2048 -t rsa -f .ssh/id_rsa -q -N ''"

for srv in $(cat /etc/hosts | grep k8sslave | awk '{print $2}');do
cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$srv -T 'tee -a >> /home/vagrant/.ssh/authorized_keys'
done
}

# setcluster(){

# }

########################Main
# startKubeadm
# setnetworkadon
# setSsh
