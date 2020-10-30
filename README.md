# Introduction
This is a Docker image posing as a virtual machine with a minimal Ubuntu 20.04, sshd, python3, pip3 and autorun functionality.
Using Docker as a vm is not the intended way, but it comes in handy every now and then...

# Prerequisites
You need Docker (and optionally Docker Compose). On Debian-ish systems:
```
$ sudo apt install docker.io docker-compose
$ sudo systemctl enable --now docker
```

# Installation
First clone this repo:
```
$ git clone https://github.com/G3CK0-NL/micro-ubuntu.git
```
Then build the image using:
```
$ sudo docker build -t micro-ubuntu:20.04 .
```

# Use
To run a container:
```
$ sudo docker run -d micro-ubuntu:20.04
```
Then you can access the container using `ssh`. Use `docker ps` and `docker inspect` to obtain the container IP.

### Environment variables
The following environment variables can be set:
 - `ROOT_PASSWORD` - The root password to set (default: `root`)
 - `AUTORUN` - Any command(s) to autorun (default: none). Output is visible in docker logs.
   The container will not terminate if autorun is complete as this is a 'vm'! :)
   You can force termination of the container after completion by appending `; kill 1` to the `AUTORUN` variable.

Example:
```
$ sudo docker run -e ROOT_PASSWORD=password -e AUTORUN=id -d micro-ubuntu:20.04
```

### Docker compose
Example to run with `docker-compose`:

```yaml
version: '3.1'

services:
  ubuntu:
    image: micro-ubuntu:20.04
    #environment:
    #  - ROOT_PASSWORD=password            # Set root user password to 'password'
    #  - AUTORUN=ls /                      # Autorun 'ls /'
    #ports:
    #  - '22:22'                           # Expose ssh port to host ip
    #volumes:
    #  - 'some/host/dir:/container/dir'    # 'Mount' a directory in the container
```
