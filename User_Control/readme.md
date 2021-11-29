# Server System
There are several groups in our server containing connectome, kimj(김종헌 교수님).
Only for connectome group, our lab, I set the system with @nemodleo and @junbeom.
## Rules for connectome group users & admin
1. UID : 10000~19999 (ex. 11111)
2. GID : 10000 (connectome group)
3. User ID info : must be the name of user
4. User ID : whatever user wants
5. Home directory : /home/connectome/{User ID}
6. Mounting/sharing directory : /data (in storage server) == /scratch (in master, node1, node2 server) -> for storing data
7. Administor user : conmaster(Sooyyoungg), kimj(김종헌 교수님)      

**_!!! Important !!! Admin(Sooyyoungg) must add all of the user information to our lab documents._**       

## Direcotry Tree
For all servers(gateway, master, node1, node2, storage) should satisfy the following dir tree.
~~~Bash
conmaster@gateway:/etc/connectome$ tree -N
.
├── adduser.conf
└── connectome_skel
    └── docker
        ├── Dockerfile
        └── share
3 directories, 2 files
~~~

# Codes
Load the codes that I always use for server control
* server_deluser.sh: deleting user account and folder in all node computers and gateway computer of lab server
* server_addkey.sh: adding the public key of each user in our all computers of lab server

server_addkey.sh & server_deluser.sh is made by @Sooyyoungg      
server_adduser_pw.sh & server_adduser_no_pw.sh & server_adduser_etc.sh is made by @nemodleo

## How to run
~~~Bash
conmaster@connectome:~/server_management$ ./server_adduser.sh {userID} {UID} {First_Lastname}
# example
conmaster@connectome:~/server_management$ ./server_adduser.sh conmaster 10000 Sooyoung_Kim
~~~
