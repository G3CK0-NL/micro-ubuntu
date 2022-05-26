# Ubuntu 20.04 image with sshd, python3, pip3 and autorun functionality.
#
# To build:
#   sudo docker build -t micro-ubuntu:20.04 .
#
# Environment variables:
#   - ROOT_PASSWORD     Root password to set (default: root)
#   - AUTORUN           Command(s) to autorun after startup (default: none)
#

FROM ubuntu:20.04

# Install sshd and python3-pip (python3 is there already)
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server python3-pip iproute2 iputils-ping dnsutils && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure sshd
RUN mkdir /var/run/sshd
RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

EXPOSE 22

# Make python available
RUN ln -s /usr/bin/python3 /usr/bin/python

# Setup default environment variables (you can override these later)
ENV ROOT_PASSWORD=root
ENV AUTORUN=echo

CMD ["sh", "-c", "echo \"root:$ROOT_PASSWORD\" | chpasswd; (($AUTORUN) &); /usr/sbin/sshd -D"]
