# Builds a Docker image with Ubuntu 17.10, g++-7.2, clang, Atom, LAPACK, ddd,
# valgrind, and mpich for "AMS 562: Introduction to Scientific Programming in C++"
# at Stony Brook University
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>
# Qiao Chen <benechiao@gmail.com>

FROM ams562/desktop:base
LABEL maintainer "Qiao Chen <benechiao@gmail.com>"

USER root
WORKDIR /tmp

# install dependencies
RUN apt-get update && \
    git clone --depth 1 https://github.com/zeromq/libzmq.git && \
    cd libzmq && mkdir build && cd build && cmake .. && make -j2 && make install

RUN git clone --depth 1 https://github.com/zeromq/cppzmq.git && \
    cd cppzmq && mkdir build && cd build && cmake .. && make -j2 && make install

# install crypto++ with cmake
RUN git clone --depth 1 https://github.com/weidai11/cryptopp.git && \
    cd cryptopp && \
    git clone --depth 1 https://github.com/noloader/cryptopp-cmake.git cmake && \
    cp cmake/cryptopp-config.cmake . && \
    cp cmake/CMakeLists.txt . && \
    mkdir build && cd build && cmake .. && make -j2 && make install

RUN git clone --depth 1 https://github.com/nlohmann/json.git && \
    cd json && mkdir build && cd build && cmake .. && make -j2 && make install

RUN git clone --depth 1 https://github.com/QuantStack/xtl.git && \
    cd xtl && mkdir build && cd build && cmake .. && make -j2 && make install

RUN git clone --depth 1 https://github.com/QuantStack/xeus.git && \
    cd xeus && mkdir build && cd build && cmake .. && make -j2 && make install

RUN git clone --depth 1 https://github.com/zeux/pugixml.git && \
    cd pugixml && mkdir build && cd build && cmake .. && make -j2 && make install

RUN git clone --depth 1 https://github.com/jarro2783/cxxopts.git && \
    cd cxxopts && mkdir build && cd build && cmake .. && make -j2 && make install

# install precompiled cling, otherwise it would take forever!
ENV CLING_ROOT=/opt/cling
RUN mkdir -p /opt/cling && \
    pip3 install --no-cache-dir tqdm && \
    git clone https://github.com/chentinghao/download_google_drive.git && \
    cp download_google_drive/download_gdrive.py download_gdrive.py && \
    python3 download_gdrive.py 10ECiK6qXeD31JwfqTqD_Dv-qpIw1dMNP build_cling.tar.xz && \
    tar xf build_cling.tar.xz && \
    cd build && \
    make install && \
    ln -sf $CLING_ROOT/bin/cling /usr/local/bin/cling && \
    ln -sf $CLING_ROOT/include/llvm /usr/local/include/llvm && \
    ln -sf $CLING_ROOT/include/llvm-c /usr/local/include/llvm-c && \
    ln -sf $CLING_ROOT/include/clang /usr/local/include/clang && \
    ln -sf $CLING_ROOT/include/cling /usr/local/include/cling

# install xeus-cling
RUN git clong --depth 1 https://github.com/QuantStack/xeus-cling.git && \
    cd xeus-cling && \
    sed -i "s/\&copt_strings/(char\ **)\&copt_strings/g" src/xoptions.cpp && \
    mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/cling .. && \
    make -j2 && make install && \
    ln -sf $CLING_ROOT/bin/xeus-cling /usr/local/bin/xeus-cling && \
    cp -r $CLING_ROOT/share/jupyter/kernels/* /usr/local/share/jupyter/kernels/

RUN ldconfig /usr/local/lib

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

########################################################
# Customization for user
########################################################

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
