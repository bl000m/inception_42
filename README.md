# Virtual machine set up

To set up a virtual machine, follow these steps:

1. Log in to the virtual machine using the command: `su -l`
2. Add the user to the sudo group: `adduser login sudo`
3. Switch to the newly added user: `sudo su login`
4. Update the package list: `sudo apt update`
5. Upgrade installed packages: `sudo apt upgrade`
6. Install the sudo package: `sudo apt install sudo`
7. Install Git: `sudo apt-get install git`
8. Install OpenSSH Server: `sudo apt-get install openssh-server`
9. Install Docker: `sudo apt-get install docker.io`
10. Grant Docker permissions to the current user: `sudo usermod -aG docker $USER`
    This command adds the current user to the "docker" group, allowing them to interact with the Docker daemon and run Docker containers.
11. Connect to the GitHub repository by creating an SSH key: `ssh-keygen`
12. Install Make: `sudo apt-get install make`
13. Modify the `/etc/hosts` file and assign `login.42.fr` to `127.0.0.1`
14. Manually create the following directories in the root: `data/mariadb` and `data/wordpress`
15. Install Docker server (docker engine) + Docker client following the steps below.  Docker Engine is responsible for running and managing Docker containers on the server, while Docker Client is used to interact with the Docker Server and execute commands.

## Installation Process for Docker Engine
1. Uninstall old versions:

`sudo apt-get remove docker docker-engine docker.io containerd runc`: Removes older versions of Docker.

2. Set up the Docker repository:

`sudo apt-get update`: Updates the apt package index.

`sudo apt-get install ca-certificates curl gnupg`: Installs necessary packages.

`sudo install -m 0755 -d /etc/apt/keyrings`: Creates a directory for the GPG key.

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`: Adds Docker's GPG key.

`sudo chmod a+r /etc/apt/keyrings/docker.gpg`: Changes permissions for the GPG key.

`echo "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`: Sets up the Docker repository.

3. Install Docker Engine:

`sudo apt-get update`: Updates the apt package index.

`sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`: Installs Docker Engine, containerd, and Docker Compose.
