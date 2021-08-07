echo  "[Task 1]  Pulling config images pull]"
kubeadm config images pull

echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

echo "[TASK 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.18.18.100 --pod-network-cidr=192.168.0.0/16

echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.20/manifests/calico.yaml >/dev/null 2>&1

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /tmp/joincluster.sh

mkdir -p /home/vagrant/.kube
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant. /home/vagrant/.kube

cp /etc/kubernetes/admin.conf /tmp/
chmod 777 /tmp/admin.conf
