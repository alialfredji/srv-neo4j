# Neo4j database on remote server. Case is used on Ubuntu

**NOTE:** This service needs a static ip.

**NOTE:** Activate termination protection on the EC2!!!

## Install Docker:
[Get Docker CE for Ubuntu | Docker Documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo groupadd docker

sudo gpasswd -a $USER docker

newgrp docker

docker run hello-world
```

## Install other needed modules

#### Docker Compose:

[From Docker docs](https://docs.docker.com/compose/install/)

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```

#### HumbleClI

```
git clone https://github.com/marcopeg/humble-cli.git /home/ubuntu/.humble-cli

sudo ln -s /home/ubuntu/.humble-cli/bin/humble.sh /usr/local/bin/humble
```

#### MakeCLI

```
sudo apt-get install make
```

## Clone repo

```
git clone https://github.com/alialfredji/srv-neo4j.git
cd srv-neo4j
```

Create `.env.local` with your costum environment variables, use `.env` as example.

## Manage instance volume and run postgres

1. Check if disk is initialized
    ````
    make status
    ````
2. Get more info about disk. Use env INSTANCE_DISK_PATH to set the right disk path
    ````
    make info
    ````
3. Mount disk to /docker-data
    ```
    make mount-disk
    ```
4. Start neo4j container
    ```
    make run-neo4j
    ```
5. Your container should be running now :)

**IMPORTANT:** set the automatic snapshot so you dont lose data or setup a backup container!!!

## Resize EBS Volume

From your cloud console, edit the volume to the new desired size.

* When disk initialization is done, login to machine and run:
    ````
    make info

    make resize-disk
    ````

