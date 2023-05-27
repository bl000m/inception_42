#Inception
##Set up virtual machine
`su -l`
adduser login sudo
sudo ‘login’

sudo apt update

sudo apt upgrade

sudo apt install sudo



sudo apt-get install git
sudo apt-get install openssh-server
sudo apt-get install docker.io



sudo usermod -aG docker $USER → this command allows the current user to be added to the "docker" group, which grants them permissions to interact with the Docker daemon and run Docker containers on the system.

to connect github repo creating ssh key: ssh-keygen

sudo apt-get install make

modify /etc/hosts to assign login.42.fr to 127.0.0.1

create manually in root data/mariadb and data/wordpress
