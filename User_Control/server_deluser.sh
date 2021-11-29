#!/bin/bash
userid=$1

# user delete in gateway
sudo -S userdel $userid
sudo -S rm -r /home/connectome/$userid

# delete user in other nodes
nodes="master node1 node2 storage"
for node in $nodes
do
        ssh -T -A conmaster@$node <<-EOF
        bash
        sudo -S userdel $userid
        sudo -S rm -r /home/connectome/$userid
EOF
done
