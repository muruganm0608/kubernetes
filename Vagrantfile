# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

config.vm.define "kubemaster.prathiksha.com" do |km|
km.vm.box = "centos/7"
#km.vm.synced_folder "/nfsshare", "/vagrant", type: "nfs"
km.vm.network "private_network", ip: "172.18.18.100"
km.vm.hostname = "kubemaster.prathiksha.com"
km.vm.provision :shell, path: "bootstrap.sh"
km.vm.provider "virtualbox" do |v|
   v.memory = "2048"
   v.cpus = "2"
end
km.vm.provision :shell, path: "bootstrap-km.sh"
end

NodeCount=1
(1..NodeCount).each do |i|
  config.vm.define "worker#{i}.prathiksha.com" do |node|
  node.vm.box = "centos/7"
 # node.vm.synced_folder "/nfsshare", "/vagrant", type: "nfs"
  node.vm.provision :shell, path: "bootstrap.sh"
  node.vm.hostname = "worker#{i}.prathiksha.com"
  node.vm.network "private_network", ip: "172.18.18.10#{i}"
  node.vm.disk :disk, size: "5GB", primary: true
  node.vm.provider "virtualbox" do |v|
   v.memory = "2048"
   v.cpus = "2"
  end
  node.vm.provision :shell, path: "bootstrap-worker.sh"
end
end
end


