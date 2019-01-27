# Image for "AMS 562: Introduction to Scientific Programming in C++" at Stony
# Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>
# Qiao Chen <benechiao@gmail.com>

FROM ams562/desktop:base
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

# ARG JSON_VERSION=3.2.0
# ENV CLING_ROOT=/opt/cling

# # install dependencies
# RUN apt-get update && \
#     apt-get install -y \
#       libffi-dev \
#       libxml2-dev \
#       libtinfo-dev \
#       && \
#     apt-get clean && \
#     git clone --depth 1 https://github.com/zeromq/libzmq.git && \
#     cd libzmq && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     git clone --depth 1 https://github.com/zeromq/cppzmq.git && \
#     cd cppzmq && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     git clone --depth 1 https://github.com/weidai11/cryptopp.git && \
#     cd cryptopp && \
#     git clone --depth 1 https://github.com/noloader/cryptopp-cmake.git cmake && \
#     cp cmake/cryptopp-config.cmake . && \
#     cp cmake/CMakeLists.txt . && \
#     mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     wget -q https://github.com/nlohmann/json/archive/v$JSON_VERSION.tar.gz && \
#     tar xf v$JSON_VERSION.tar.gz && \
#     cd json-$JSON_VERSION && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     git clone --depth 1 https://github.com/QuantStack/xtl.git && \
#     cd xtl && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     git clone https://github.com/QuantStack/xeus.git && \
#     cd xeus && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     git clone --depth 1 https://github.com/zeux/pugixml.git && \
#     cd pugixml && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     git clone --depth 1 https://github.com/jarro2783/cxxopts.git && \
#     cd cxxopts && mkdir build && cd build && cmake .. && make -j2 && make install && \
#     cd /tmp && \
#     mkdir -p /opt/cling && \
#     pip3 install --no-cache-dir tqdm && \
#     git clone https://github.com/chentinghao/download_google_drive.git && \
#     cp download_google_drive/download_gdrive.py download_gdrive.py && \
#     python3 download_gdrive.py 1Fq9u0NvpZG7DBVF1OAHZs_xKDMKBgM45 build_cling.tar.xz && \
#     tar xf build_cling.tar.xz && \
#     cd cling/src/build && \
#     make install && \
#     ln -sf $CLING_ROOT/bin/cling /usr/local/bin/cling && \
#     ln -sf $CLING_ROOT/include/llvm /usr/local/include/llvm && \
#     ln -sf $CLING_ROOT/include/llvm-c /usr/local/include/llvm-c && \
#     ln -sf $CLING_ROOT/include/clang /usr/local/include/clang && \
#     ln -sf $CLING_ROOT/include/cling /usr/local/include/cling && \
#     cd /tmp && \
#     git clone https://github.com/QuantStack/xeus-cling.git && \
#     cd xeus-cling && \
#     sed -i "s/\&copt_strings/(char\ **)\&copt_strings/g" src/xoptions.cpp && \
#     mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/cling .. && \
#     make -j2 && make install && \
#     ln -sf $CLING_ROOT/bin/xeus-cling /usr/local/bin/xeus-cling && \
#     cp -r $CLING_ROOT/share/jupyter/kernels/* /usr/local/share/jupyter/kernels/ && \
#     ldconfig /usr/local/lib && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install jupyter and xeus-cling
RUN export PATH=${MINICONDA_ROOT}/bin:$PATH && \
    conda install jupyter -y && conda install xeus-cling -c conda-forge && \
    conda install -c conda-forge jupyter_latex_envs -y && \
    hash jupyter && \
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
    conda clean -a -y

########################################################
# Customization for user
########################################################

# RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
