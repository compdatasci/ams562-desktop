# Builds a Docker image with Ubuntu 18.04, GCC-7.3, clang, vscode, LAPACK, ddd,
# valgrind, OpenMPI, OpenMP, etc. for "AMS 562: Introduction to Scientific Programming in C++"
# at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>
# Qiao Chen <benechiao@gmail.com>

FROM compdatasci/vscode-desktop:latest
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

ADD image/home $DOCKER_HOME/

# Install system packages
RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y --no-install-recommends \
        doxygen \
        git \
        vim \
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
    apt-get clean && \
    pip3 install --no-cache-dir \
      numpy \
      scipy \
      sympy==1.1.1 \
      pandas \
      matplotlib \
      sphinx \
      sphinx_rtd_theme \
      cython \
      flufl.lock \
      ply \
      PyQt5 \
      ipython \
      jupyter \
      jupyter_latex_envs \
      ipywidgets && \
    jupyter nbextension install --py --system \
         widgetsnbextension && \
    jupyter nbextension enable --py --system \
         widgetsnbextension && \
    jupyter-nbextension install --py --system \
        latex_envs && \
    jupyter-nbextension enable --py --system \
        latex_envs && \
    jupyter-nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-spell-check-1.0.zip && \
    jupyter-nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-document-tools-1.0.zip && \
    jupyter-nbextension install --system \
        https://bitbucket.org/ipre/calico/downloads/calico-cell-tools-1.0.zip && \
    jupyter-nbextension enable --system \
        calico-spell-check && \
    git clone https://github.com/VundleVim/Vundle.vim.git $DOCKER_HOME/.vim/bundle/Vundle.vim && \
    vim -c "PluginInstall" -c "quitall" && \
    $DOCKER_HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --system-boost --system-libclang && \
    touch $DOCKER_HOME/.log/jupyer.log && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

########################################################
# Customization for user
########################################################

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
