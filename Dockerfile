FROM ubuntu:18.04
MAINTAINER Anders Harrisson <anders.harrisson@gmail.com>

# Install required packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install build-essential \
                   chrpath \
                   cpio \
                   curl \
                   debianutils \
                   diffstat \
                   gawk \
                   gcc-multilib \
                   git-core \
                   iputils-ping \
                   libsdl1.2-dev \
                   locales \
                   python \
                   python3 \
                   python3-pexpect \
                   python3-pip \
                   socat \
                   sudo \
                   texinfo \
                   unzip \
                   wget \
                   xterm \
                   xz-utils && \
    dpkg-reconfigure --frontend noninteractive locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set system lang
ENV LANG en_US.utf8

# Install repo
RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/local/bin/repo

# Create user and group
RUN groupadd -g 1000 yocto && \
    useradd -u 1000 -g yocto -G sudo,users,yocto -m -s /bin/bash yocto

# Create yocto installation directory
ENV YOCTO_INSTALL_PATH "/opt/yocto"
RUN mkdir -p $YOCTO_INSTALL_PATH && \
    chown yocto:yocto $YOCTO_INSTALL_PATH

USER yocto

WORKDIR ${YOCTO_INSTALL_PATH}

# Install Yocto
ENV YOCTO_RELEASE "rocko"
RUN git clone --branch ${YOCTO_RELEASE} git://git.yoctoproject.org/poky

# Install FSL community BSP
RUN mkdir -p ${YOCTO_INSTALL_PATH}/fsl-community-bsp && \
    cd ${YOCTO_INSTALL_PATH}/fsl-community-bsp && \
    repo init -u https://github.com/Freescale/fsl-community-bsp-platform -b ${YOCTO_RELEASE} && \
    repo sync

WORKDIR ${YOCTO_INSTALL_PATH}/fsl-community-bsp
