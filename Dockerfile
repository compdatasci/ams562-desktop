# Builds a Docker image with Ubuntu 16.04, g++-5.4, g++-7.1, Atom, LAPACK, ddd,
# valgrind, and mpich for "AMS 562: Introduction to Scientific Programming in C++"
# at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/desktop:latest
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"

USER root
WORKDIR /tmp

# Install system packages
RUN add-apt-repository ppa:webupd8team/atom && \
    add-apt-repository ppa:jonathonf/gcc-7.1 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        gcc-7 \
        g++-7 \
        gfortran \
        cmake \
        bison \
        flex \
        git \
        bash-completion \
        bsdtar \
        rsync \
        wget \
        gdb \
        ddd \
        valgrind \
        electric-fence \
        ccache \
        \
        liblapack-dev \
        libmpich-dev \
        libopenblas-dev \
        mpich \
        \
        meld \
        atom \
        clang-format && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

########################################################
# Customization for user
########################################################

ENV GIT_EDITOR=vi EDITOR=atom
ADD config/atom $DOCKER_HOME/.config/atom
COPY WELCOME $DOCKER_HOME/WELCOME
RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME/.config
USER $DOCKER_USER
RUN echo 'export OMP_NUM_THREADS=$(nproc)' >> $DOCKER_HOME/.profile && \
    apm install \
        language-cpp14 \
        language-matlab \
        language-fortran \
        language-docker \
        autocomplete-python \
        autocomplete-fortran \
        git-plus \
        merge-conflicts \
        split-diff \
        gcc-make-run \
        platformio-ide-terminal \
        intentions \
        busy-signal \
        linter-ui-default \
        linter \
        linter-gcc \
        linter-gfortran \
        dbg \
        output-panel \
        dbg-gdb \
        auto-detect-indentation \
        clang-format && \
    ln -s -f $DOCKER_HOME/.config/atom/* $DOCKER_HOME/.atom && \
    rm -rf /tmp/*

WORKDIR $DOCKER_HOME
USER root
