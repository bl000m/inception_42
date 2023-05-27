# Virtual machine set up
<p align="center">
	<img src="https://github.com/bl000m/inception_42/blob/main/vb_icon.png" width="200">
</p>
<br>

## Recommendations for Setting Up a Virtual Machine during the macOS to Linux Transition (42 School Machines)

When setting up a virtual machine, particularly if you're working on Inception during the transition from macOS to Linux on the 42 School machines, it is strongly recommended to follow these guidelines to avoid potential issues caused by frequent machine freezing:

* Allocate Sufficient Hard Disk Space: It is recommended to be generous with the hard disk allocation, allocating at least 20 GB in the `sgoinfre` directory. This ensures that you have enough space to install and run applications without running into storage constraints.

* Avoid Partitioning: For simplicity and ease of management, it is advisable to avoid partitioning the virtual machine's hard disk. By keeping the disk as a single partition, it eliminates the complexity associated with managing multiple partitions.

* Avoid Logical Volume Management (LVM): While testing Docker images and containers, it's crucial to avoid using LVM unless you have a clear understanding of how it works. Improper management of Docker images and containers, such as not stopping or removing them correctly, can lead to excessive disk usage. This can quickly saturate swap, home, or root partitions, resulting in performance issues or disk space shortages.
<br>
 
## Once created the virtual machine, follow these steps for it to be a playground for this project:
<p align="center">
	<img src="https://github.com/bl000m/inception_42/blob/main/shell2.png" width="200">
</p>
<br>

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

## Installation Process for Docker Engine + client
<p align="center">
	<img src="https://jolicode.com/media/original/2013/10/homepage-docker-logo.png" width="200">
</p>
<br>

### NB
* Docker client / Docker engine (server) / REST API
	* The following installation process includes both Docker Server (Docker Engine) and Docker Client. 
		* Docker Engine is responsible for running and managing Docker containers on the server
		* Docker Client is used to interact with the Docker Server and execute commands.
	* Docker client and server communicate with each other through a REST API. The Docker client is a command-line tool that allows users to interact with the Docker server, which is responsible for managing and running Docker containers.
	* When you execute Docker commands using the client, such as running a container or building an image, the client sends HTTP requests to the server's REST API. These requests contain instructions and parameters for the desired Docker operation.
	<br>

* REST API role
	* By implementing a REST API, the server exposes a set of endpoints (URLs) that represent different resources and actions. The client can then make HTTP requests to these endpoints, specifying the desired resource or operation.
	* The Docker server receives these requests, processes them, and performs the necessary actions. It manages container lifecycles, handles image operations, and orchestrates the overall Docker environment.

* The KERNEL role
	* The kernel provides the underlying mechanisms for container isolation and resource management, allowing Docker to function efficiently and securely.
	* Docker leverages the capabilities provided by the Linux kernel, such as namespaces and control groups (cgroups), to isolate and manage containers. Namespaces allow Docker to create isolated environments for processes, such as network, filesystem, and process namespaces. Cgroups ensure resource allocation and utilization control for containers.
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

## **Key Concepts**
<p align="center">
	<img src="https://github.com/bl000m/inception_42/blob/main/concepts.png" width="200">
</p>
<br>

* Dockerfile: A blueprint used to create an image.
* Image: A template that contains all the necessary components to create a container. Each image is specific to an architecture.
* Container: An isolated process running on a host.
<br>

### Dockerfile
* **Characteristics**:
	* No indentation.
	* Instructions written in uppercase.
	* Escape character: \
<br>

* **Consists of three parts**:
	* Starting image (FROM)
	* Instructions
	* Last line (RUN or ENTRYPOINT) used to launch the process(es) or supervise them.
<br>

* **Instructions**:
	* FROM: Specifies the base image.
	* WORKDIR: Sets the working directory for subsequent instructions.
	* ARG: Defines variables that users can pass at build-time to the builder.
	* ENV: Sets environment variables.
	* USER: Sets the user to execute the following instructions and the final process (should not be ROOT).
	* ADD: Adds local or remote files to the image (via curl). The --chown flag can be used to change the owner of the added file.
	* COPY: Similar to ADD, but does not allow downloading remote files.
	* RUN: Executes shell commands, utilizes caches, and creates layers (each RUN instruction adds a different layer).
	* CMD: Defines the main process to be launched. It is typically specified in a list format. For example: CMD ["python3", "-m", "flask", "run"]
	* ENTRYPOINT: Similar to CMD. Note that using CMD and ENTRYPOINT together can be dangerous.
	* LABEL: Defines and injects metadata (a collection of key-value pairs). This can be inspected using the "docker image inspect" command.
	* EXPOSE: Declares ports on which the processes launched by the image will listen. For example: EXPOSE 80/tcp (with protocol specified).
<br>

* **Image handling in the shell (commands to build, run, and inspect images)**:
	* docker build -t image_name:tag_name .: Builds an image with the specified image_name and tag_name. The '.' indicates that the image should be built in the current directory (a different directory can be specified).
	* `docker images`: Lists the available images.
	* `docker run -d --name container_name image_name:tag_name`: Creates a container (process) with the specified container_name using the specified image.
	* `docker ps`: Checks if the container is running.
	* `docker logs container_name`: Displays the logs of the specified container.
	* `docker image inspect image_name:tag_name`: Inspects the metadata of the specified image.
	* `docker history image_name:tag_name` => to visualize all the layers created
	* `docker exec -it container_name bash`: Opens an interactive bash session within the specified container.
	* Once inside the container's bash shell, running the command `env` will display the set environment variables.
<br>


* **Layers**:
	* Each instruction in an image creates a layer. You can visualize all the layers created for an image using the `docker history image_name:tag_name` command.
	* If two images have the same instruction, they can share the related layer, resulting in resource optimization through caching. When downloading an image from a remote registry, Docker compares the layers of the remote repository with the ones stored on our machine. It avoids downloading layers that are already present locally.
	* Each layer is read-only. When launching an image, Docker creates a copy-on-write layer. It assembles the read-only layers and creates a write layer on top of them, which becomes the container. This approach allows for efficient use of resources and faster container creation.
<br>

* **Good Practices**:
	* Group similar instructions to reduce the number of layers and make the image size lighter. However, it's important to fragment them enough to allow different images to share the cache of common instructions. Finding a balance between these two considerations is crucial.
	* Play with the order of instructions. Place the instructions that are less likely to change at the top of the Dockerfile and the more variable instructions towards the end. This can help optimize caching and improve build times.
<br>


## Sources: a video playlist with the most interesting tuto on the subject (click on the image)
[![](https://github.com/bl000m/inception_42/blob/main/playlist%20inception.png)](https://www.youtube.com/playlist?list=PLuO5MajLbJtlpqXgQABdxC0XCaqPq76mh)

<br>

