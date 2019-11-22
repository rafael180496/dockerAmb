# **Docker**

## **Introduccion**

### **Intalacion**

#### **Repositiorio:**

```bash
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

```

#### **Intalacion:**

```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo apt-cache madison docker-ce

docker-ce | 5:18.09.1~3-0~debian-stretch | https://download.docker.com/linux/debian stretch/stable amd64 Packages
  docker-ce | 5:18.09.0~3-0~debian-stretch | https://download.docker.com/linux/debian stretch/stable amd64 Packages
  docker-ce | 18.06.1~ce~3-0~debian        | https://download.docker.com/linux/debian stretch/stable amd64 Packages
  docker-ce | 18.06.0~ce~3-0~debian        | https://download.docker.com/linux/debian stretch/stable amd64 Packages

sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

sudo docker run hello-world
```

### **Docker ps**

Muestra las imagenes que estan ejecutando

```bash
docker ps
```

### **Docker pull**

Descarga la imagen de un contenedor

```bash
docker pull nameimagen:version
```

### **Docker run**

corre un contenedor descargado

```bash
# mirar todos los contenedor
docker ps -a

docker run nameimagen comandos
#shell linux
docker run -it contenedor sh
#correr un contenedor
docker run -i idcontainer sh
#correr un contenedor demonio
docker run -i -d idcontainer
# correr un contenedor ya existente 
docker exec -it idcon
```

### **Docker imagen**

es una version de contenedor

```bash
#elimnar
docker rmi Image1
#stop
docker stop image1
# darle commit a un contenedor
docker commit idcontainer
#darle un tag
docker image tag idcontainer nombretag:version

```

### **Docker File**

compila un contenedor en un archivo

```docker
#ARCHIVO Y COMANDOS
#CONTENEDOR
FROM ubuntu
#intalacion automatica
RUN apt-get update && apt-get install  figlet -y

#guardar Dockerfile
docker build -t nombre:version .
# mirar las imagenes
docker image ls | head
```

### **Docker Volumenes**

```bash
# correr un columen
docker run -v directorig:directocont -d contenedor
#correr como demonio y amarrar un puerto
# si es -e es una variable de entorno q le envias
docker run -p 8080:80 -d nginx
#intalar docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# crear volumenes
docker volume create name
docker volume ls

# correr archivos yaml
docker-compose up -d
```

### **Docker netowrking**

```bash
bridge --> pasa un trafico
host --> bindea el puerto de tu maquina
overlay --> se comunican los servicio entre si
macvlan --> asigna una dirrecion mac

#elimnar contenedores
docker rm id
# imagen linux lite
alpine
```

### **Recursos de anfrition**

```bash
sudo apt install htop
```

### **Recursos de contenedores**

```bash
sudo docker stats
```

### **Borar todo los sobrante**

```bash
sudo docker system prune
```

### **Inpeccion de contenedor**

```bash
sudo docker inspect ID
```

### **Copiar archivos**

```bash
sudo docker cp ID path
```

### **Logs de contenedor**

```bash
sudo docker logs --tail=30 -t IDCONT
```
