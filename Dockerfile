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

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

########################################################
# Customization for user
########################################################

RUN chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME

WORKDIR $DOCKER_HOME
