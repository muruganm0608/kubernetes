#!/usr/bin/env bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "[Task- 1] : Updating yum repository"
yum update -y
echo "[Task- 2] : Installing Docker"
yum install docker -y 2>/dev/null
yum install sshpass -y 2>/dev/null
sudo useradd -p "8lupaTuWetZpk" user1 ## Hashed Passwd here is "redhat"
echo "[Task- 3] : Enabling & Starting docker service"
systemctl enable --now docker
systemctl enable --now kubelet.service
echo "[Task- 4] : Sleeping for 5sec"
sleep 5
echo "[Task- 5] : Installing kubelet & kubeadm"
cgroups_driver=`docker info 2>/dev/null | grep -i cgroup | awk -F':' '{print $2}' | xargs`
yum install kubeadm-1.21* kubectl-1.21* -y
sed -i '/swap/d' /etc/fstab
swapoff -a
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
setenforce 0
iptables -F
iptables-save
echo "[Task- 6]: Adding cgroups_driver $cgroups_driver"
sed -i 's/KUBELET_EXTRA_ARGS=.*/KUBELET_EXTRA_ARGS=--cgroup-driver='"$cgroups_driver"'/g' /etc/sysconfig/kubelet
systemctl enable --now kubelet.service
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
