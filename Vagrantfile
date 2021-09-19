servers=[
   {
    :hostname => "k8smaster",
    :ip => "192.168.100.2",
    :type => "master",
    :ram => 2024,
    :cpu => 3
  },
  {
    :hostname => "k8sslave",
    :ip => "192.168.100.3",
    :type => "slave",
    :ram => 2024,
    :cpu => 2
  }
]

Vagrant.configure("2") do |config|

  # hosts=''
  # servers.each do |machine|
  #   hosts+= "echo '" + machine[:ip]+"  "+machine[:hostname]+"' >> /etc/hosts \n"
  # end
      
  servers.each do |machine|
    
       
    config.vm.define machine[:hostname] do |node|
        
        node.vm.box = "bento/ubuntu-20.04"
        node.vm.hostname = machine[:hostname]
        node.vm.network "public_network",  ip: machine[:ip]
        node.vm.provider "virtualbox" do |vb|
            vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
            vb.customize ["modifyvm", :id, "--cpus", machine[:cpu]]
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
            vb.customize ["modifyvm", :id, "--name", machine[:hostname]]
        end
        # node.vm.provision :shell, :path => "common.sh"
        # node.vm.provision :shell, :inline => hosts
        # if machine[:type] == 'master'
        #   node.vm.provision :shell, :path => "controleplane.sh"
        # end

        
    end

    

  end
  

end
