# Inception
A personal guide to inception.

# What is Inception?
Inception is a project to get you acquainted with Docker, a platform that allows for lightweight and compatability problem free testing, development and exectution of programs and applications.

## Understanding the The Subject Contents
# General Guidelines
This project needs to be done on a Virtual Machine.
    For this project we need root access for Docker's host system. This isn't possible on our user's at 42 and thus the need for virtual machines.

All the files required for the configuration of your project must be placed in a srcs
folder.
    -

A Makefile is also required and must be located at the root of your directory. It must set up your entire application (i.e., it has to build the Docker images using docker-compose.yml).
    (WHAT IS REQUIRED OF THE MAKEFILE)

This subject requires putting into practice concepts that, depending on your background, you may not have learned yet. Therefore, we advise you not to hesitate to read a lot of documentation related to Docker usage, as well as anything else you will find helpful in order to complete this assignment.

# Mandatory part

This project consists in having you set up a small infrastructure composed of different services under specific rules. The whole project has to be done in a virtual machine. You have to use docker compose.

Each Docker image must have the same name as its corresponding service.

Each service has to run in a dedicated container.

For performance matters, the containers must be built either from the penultimate stable version of Alpine or Debian. The choice is yours.

You also have to write your own Dockerfiles, one per service. The Dockerfiles must be called in your docker-compose.yml by your Makefile.

It means you have to build yourself the Docker images of your project. It is then forbidden to pull ready-made Docker images, as well as using services such as DockerHub (Alpine/Debian being excluded from this rule).

You then have to set up:
    • A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.

    • A Docker container that contains WordPress + php-fpm (it must be installed and configured) only without nginx.

    • A Docker container that contains MariaDB only without nginx.

    • A volume that contains your WordPress database.

    • A second volume that contains your WordPress website files.

    • A docker-network that establishes the connection between your containers.

Your containers have to restart in case of a crash.

TIP: A Docker container is not a virtual machine. Thus, it is not recommended to use any hacky patch based on ’tail -f’ and so forth when trying to run it. Read about how daemons work and whether it’s a good idea to use them or not.

FORBIDDEN: Of course, using network: host or --link or links: is forbidden. The network line must be present in your docker-compose.yml file. Your containers musn’t be started with a command running an infinite loop. Thus, this also applies to any command used as entrypoint, or used in entrypoint scripts. The following are a few prohibited hacky patches: tail -f, bash, sleep infinity, while true.

TIP: Read about PID 1 and the best practices for writing Dockerfiles.

In your WordPress database, there must be two users, one of them being the administrator. The administrator’s username can’t contain admin/Admin or administrator/Administrator (e.g., admin, administrator, Administrator, admin-123, and so forth).

Your volumes will be available in the /home/login/data folder of the host machine using Docker. Of course, you have to replace the login with yours.

To make things simpler, you have to configure your domain name so it points to your local IP address.

This domain name must be login.42.fr. Again, you have to use your own login.

For example, if your login is wil, wil.42.fr will redirect to the IP address pointing to wil’s website.

The latest tag is prohibited.

No password must be present in your Dockerfiles.

It is mandatory to use environment variables.

Also, it is strongly recommended to use a .env file to store environment variables. The .env file should be located at the root of the srcs directory.

Your NGINX container must be the only entrypoint into your infrastructure via the port 443 only, using the TLSv1.2 or TLSv1.3 protocol.


# NGINX
# YAML
    YAML stands for either yet another markdown language or YAML aint markdown language. Second is funnier and stupider which probably makes it the original definition. YAML is similar to JSON but instead of parentheses it uses python style indents. YAML also supports JSON type parentheses mixed into it. 

### SELF LEARNING JOURNEY
## PART 1: Virtual Machine


## PART 2: Docker Setup

## PART 3: BASIC NGINX CONTAINER

Pull the image with: 

    docker image pull nginx:latest

The image is now on your computeer and you can check it exists with 

    docker images

From this image we can run a container with

    docker container run <IMAGE ID>

You'll notice at this point the command blocks your terminal. When you end the process this stops your container which is not so useful. 

Run again with -d (detach) to detach the process from your terminal. 

    docker container run -d <Image Id> 

This process will now run until such a time as you manually stop it.

Now the container is detached you can use your terminal to check it exists with ps (process status)

    docker ps

This will display all current containers. 

Try running another container from the same image and see what appears when you check the process status command.

You wont get a valid URL with either container. NGINX will run on port 80 (by default) WITHIN the container so on your local machine there is no way to access it.

Let's end our containers as theyre no longer useful.

    docker container stop <CONTAINER ID>

Start the container with -p to (publish) the container 80 port to the 9000 (arbitrary) port on your local machine.

    docker container run -d -p 9000:80 <CONTAINER ID> 

Test this by typing "localhost:9000" in your web browser.

# PART 4: SUBJECT NGINX CONTAINER 

NGINX needs to run in a debian/alpine container and needs to be built using a dockerfile. A dockerfile is a way to build a container from an image without running all the commands individually every time you want to build the container. Let's build the most basic one.

In your dockerfile lets write the following:

    FROM FROM alpine:latest

    CMD ["echo", "Hello, World!"]

No we can build an image from this dockerfile with docker build. In your terminal execute

    docker build --tag 'alpine' <PATH TO FOLDER WITH DOCKERFILE IN>

We can see our image if we run 

    docker images 

We can see no containers if we run the following because no container has been built, only an image.

    docker ps

To make a container from the image we do as above

    docker container run <IMAGE ID>

We notice this prints hello world into our terminal. This is executed by our container initialisation process and as soon as the CMD command executes the conatainer exits. 

# PART 5: DOCKER-COMPOSE
Lets go one step further and make a docker-compose to build our container