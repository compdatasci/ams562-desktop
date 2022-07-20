# Builds a Docker image with Ubuntu 22.04, GCC-11.2, clang, vscode, LAPACK, ddd,
# valgrind, OpenMPI, OpenMP, etc. for "AMS 562: Introduction to Scientific Programming in C++"
# at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>
# Qiao Chen <benechiao@gmail.com>

FROM x11vnc/vscode-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ADD image/home $DOCKER_HOME/

# Install system packages
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
        doxygen \
        git \
        gdb \
        ddd \
        valgrind \
        electric-fence \
        libeigen3-dev \
        libopenblas-dev \
        liblapacke-dev \
        libopenmpi-dev \
        openmpi-bin \
        libomp-dev \
        meld \
        clang \
        clang-format \
        swig3.0 \
        python \
        python-dev \
        pandoc \
        libnss3 \
        libdpkg-perl \
        ttf-dejavu \
        debhelper \
        devscripts \
        gnupg \
        uuid-dev \
        libuuid1 \
        uuid-runtime \
        libboost-all-dev \
        && \
    apt clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install miniconda
ENV MINICONDA_ROOT=/usr/local/miniconda
RUN \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p ${MINICONDA_ROOT} && \
    rm -f /tmp/miniconda.sh && \
    touch $DOCKER_HOME/.log/jupyer.log && \
    echo "PATH=${MINICONDA_ROOT}/bin:\$PATH" >> $DOCKER_HOME/.profile && \
    rm -rf /tmp/*

########################################################
# Customization for user
########################################################

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
