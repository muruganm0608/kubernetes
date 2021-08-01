echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo "[TASK - 1] Joining cluster"
sshpass -p "redhat" scp -o StrictHostKeyChecking=no user1@172.18.18.100:/tmp/joincluster.sh /tmp
sh /tmp/joincluster.sh
