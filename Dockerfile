FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

ENV GHIDRA_REPOS_PATH /svr/repositories
ENV GHIDRA_INSTALL_PATH /opt
ENV GHIDRA_VERSION 9.0.2
ENV GHIDRA_SHA_256 10ffd65c266e9f5b631c8ed96786c41ef30e2de939c3c42770573bb3548f8e9f

ENV JAVA_11_URL https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
ENV JAVA_DIR_NAME jdk-11.0.2
ENV JAVA_HOME /usr/lib/jvm/${JAVA_DIR_NAME}

# Create ghidra user.
RUN useradd -m ghidra && \
    adduser ghidra sudo && \
    echo "ghidra:password" | chpasswd && \
    usermod -aG sudo ghidra

RUN apt-get update && apt-get install -y \
    vim \
    wget \
    unzip \
    libfreetype6 \
    ubuntu-desktop \
    sudo 

# Install Java 11.
RUN cd /home/ghidra && \
    wget --progress=bar:force -O openjdk.tar.gz ${JAVA_11_URL} && \
    mkdir /usr/lib/jvm && \
    tar -xzf openjdk.tar.gz --directory /usr/lib/jvm && \
    rm openjdk.tar.gz && \
    echo "/usr/lib/jvm/${JAVA_DIR_NAME}/bin:${PATH}" > /etc/environment
ENV PATH "/usr/lib/jvm/${JAVA_DIR_NAME}/bin:${PATH}"

# Get Ghidra.
RUN cd ${GHIDRA_INSTALL_PATH} && \
    wget --progress=bar:force -O ghidra_${GHIDRA_VERSION}.zip https://ghidra-sre.org/ghidra_9.0.2_PUBLIC_20190403.zip && \
    sha256sum ghidra_${GHIDRA_VERSION}.zip | awk '{print $1}' | grep -q $GHIDRA_SHA_256 && \
    unzip ghidra_${GHIDRA_VERSION}.zip && \
    mv ghidra_${GHIDRA_VERSION} ghidra && \
    rm ghidra_${GHIDRA_VERSION}.zip && \
    chown -R ghidra: ${GHIDRA_INSTALL_PATH}/ghidra

# Setup Ghidra's version tracking repositories volume.
#RUN mkdir -p ${GHIDRA_REPOS_PATH} && \
#    chown -R ghidra: ${GHIDRA_REPOS_PATH}
#VOLUME ${GHIDRA_REPOS_PATH}

# Setup user environment.
USER ghidra
WORKDIR /home/ghidra
ENV HOME /home/ghidra

#COPY ghidra/Decompile2.java /home/ghidra
#COPY ghidra/a.out /home/ghidra
#COPY ghidra/decomple.sh /home/ghidra

#CMD [ '/bin/bash'  ]

