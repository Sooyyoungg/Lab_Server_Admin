#!/bin/bash
userid=$1
public_key=$2

# add public key in gateway
cd /home/connectome/$userid
sudo -S mkdir .ssh
cd .ssh
sudo -S touch authorized_keys
sudo -S chmod 777 authorized_keys
sudo -S echo $public_key >> authorized_keys
sudo -S chgrp connectome authorized_keys
sudo -S chown $userid authorized_keys
sudo -S chmod 755 authorized_keys
cd ..
sudo -S chgrp connectome .ssh
sudo -S chown $userid .ssh

# add public key in other nodes
nodes="master node1 node2 storage"
for node in $nodes; do
ssh -A conmaster@$node <<-EOF
        bash
        cd /home/connectome/$userid
        sudo -S mkdir .ssh
        cd .ssh
        sudo -S touch authorized_keys
        sudo -S chmod 777 authorized_keys
        sudo -S echo $public_key >> authorized_keys
        sudo -S chmod 755 authorized_keys
        sudo -S chgrp connectome authorized_keys
        sudo -S chown $userid authorized_keys
        cd ..
        sudo -S chgrp connectome .ssh
        sudo -S chown $userid .ssh
EOF
done
