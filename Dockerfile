# Image with for "AMS 562: Introduction to Scientific Programming in C++" at
# Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>
# Qiao Chen <benechiao@gmail.com>

FROM ams562/desktop:cling
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

# ADD image/home $DOCKER_HOME/

# Install Atom
# RUN add-apt-repository ppa:webupd8team/atom && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends atom && \
#     apt-get clean && \
#     echo "move_to_config atom" >> /usr/local/bin/init_vnc && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

########################################################
# Customization for user
########################################################

ENV GIT_EDITOR=vim EDITOR=code
COPY WELCOME $DOCKER_HOME/WELCOME

# RUN apm install \
#       language-fortran \
#       language-docker \
#       autocomplete-python \
#       autocomplete-fortran \
#       autocomplete-clang \
#       git-plus \
#       merge-conflicts \
#       platformio-ide-terminal \
#       intentions \
#       busy-signal \
#       linter-ui-default \
#       linter \
#       linter-clang \
#       linter-gfortran \
#       dbg \
#       output-panel \
#       dbg-gdb \
#       atom-beautify \
#       file-icons \
#       fonts \
#       linter-pylint \
#       minimap \
#       atom-material-ui \
#       atom-material-syntax-dark \
#       markdown-preview-plus && \
#     rm -rf /tmp/* && \
#     echo '@atom .' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart && \
RUN echo "export OMP_NUM_THREADS=\$(nproc)" >> $DOCKER_HOME/.profile && \
    chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

# switch user, install sync-setting
USER $DOCKER_USER
WORKDIR $DOCKER_HOME

RUN code --install-extension Shan.code-settings-sync

USER root
WORKDIR $DOCKER_HOME
