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

ENV DEBIAN_FRONTEND=noninteractive

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
        python3 \
        python3-dev \
        pandoc \
        libnss3 \
        libdpkg-perl \
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
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(arch).sh \
    -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p ${MINICONDA_ROOT} && \
    rm -f /tmp/miniconda.sh && \
    touch $DOCKER_HOME/.log/jupyer.log && \
    echo "PATH=${MINICONDA_ROOT}/bin:\$PATH" >> $DOCKER_HOME/.profile && \
    rm -rf /tmp/*

# install jupyter and xeus-cling in the cling environment
RUN export PATH=${MINICONDA_ROOT}/bin:$PATH && \
    if [ "$(uname -m)" = "aarch64" ]; then \
        conda install -y "python>=3.9" jupyter jupyterlab xeus-cling gcc_linux-aarch64=9.4.0 -c conda-forge; \
    else \
        conda install -y "python>=3.9" jupyter jupyterlab xeus-cling gcc_linux-64=9.4.0 -c conda-forge; \
    fi && \
    conda clean -a -y

########################################################
# Customization for user
########################################################
ENV GIT_EDITOR=vim EDITOR=code
COPY WELCOME $DOCKER_HOME/WELCOME

RUN echo "export OMP_NUM_THREADS=\$(nproc)" >> $DOCKER_HOME/.profile && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

USER root
WORKDIR $DOCKER_HOME
