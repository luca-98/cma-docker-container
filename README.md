# cma-docker

### Update Server

```
apt update -y
apt upgrade -y
apt-get clean
```

### Set timezone

```
timedatectl set-timezone Asia/Ho_Chi_Minh
```

### Install Docker and docker-compose

```
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
docker --version
curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

### Clone source code

```
cd /usr/local/src
git clone https://github.com/CMATeam/cma-docker.git
cd /usr/local/src/cma-docker/client
git clone https://github.com/CMATeam/cma-client.git
cd /usr/local/src/cma-docker/server
git clone https://github.com/CMATeam/cma-server.git
```

### Build Server
```
cd /usr/local/src/cma-docker/client/cma-client
git pull
cd /usr/local/src/cma-docker/server/cma-server
git pull
cd ../../
docker-compose up --build -d
```
