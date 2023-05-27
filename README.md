# Virtual machine set up
<p align="center">
	<img src="https://github.com/bl000m/inception_42/blob/main/vb_icon.png" width="200">
</p>
<br>

## Recommendations for Setting Up a Virtual Machine during the macOS to Linux Transition (42 School Machines)

When setting up a virtual machine, particularly if you're working on Inception during the transition from macOS to Linux on the 42 School machines, it is strongly recommended to follow these guidelines to avoid potential issues caused by frequent machine freezing:

* Allocate Sufficient Hard Disk Space: It is recommended to be generous with the hard disk allocation, allocating at least 20 GB or more. This ensures that you have enough space to install and run applications without running into storage constraints.

* Avoid Partitioning: For simplicity and ease of management, it is advisable to avoid partitioning the virtual machine's hard disk. By keeping the disk as a single partition, it eliminates the complexity associated with managing multiple partitions.

* Avoid Logical Volume Management (LVM): While testing Docker images and containers, it's crucial to avoid using LVM unless you have a clear understanding of how it works. Improper management of Docker images and containers, such as not stopping or removing them correctly, can lead to excessive disk usage. This can quickly saturate swap, home, or root partitions, resulting in performance issues or disk space shortages.
<br>
 
## Once created the virtual machine, follow these steps for it to be a playground for this project:

1. `su -l`
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
<br>

## Installation Process for Docker Engine
<p align="center">
	<img src="https://jolicode.com/media/original/2013/10/homepage-docker-logo.png" width="200">
</p>
<br>

### Uninstall old versions:

* `sudo apt-get remove docker docker-engine docker.io containerd runc`: Removes older versions of Docker.
<br>

### Set up the Docker repository:

* `sudo apt-get update`: Updates the apt package index.

* `sudo apt-get install ca-certificates curl gnupg`: Installs necessary packages.

* `sudo install -m 0755 -d /etc/apt/keyrings`: Creates a directory for the GPG key.

* `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`: Adds Docker's GPG key.

* `sudo chmod a+r /etc/apt/keyrings/docker.gpg`: Changes permissions for the GPG key.

* `echo "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null`: Sets up the Docker repository.

<br>

### Install Docker Engine:

* `sudo apt-get update`: Updates the apt package index.

* `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin`: Installs Docker Engine, containerd, and Docker Compose.
<br>

## Sources: a video playlist with the most interesting tuto on the subject (click on the image)
[![Image Description](https://github.com/bl000m/inception_42/blob/main/playlist%20inception.png)]([https://www.youtube.com/playlist?list=PLuO5MajLbJtlpqXgQABdxC0XCaqPq76mh]
<br>
(https://www.youtube.com/playlist?list=PLuO5MajLbJtlpqXgQABdxC0XCaqPq76mh))

