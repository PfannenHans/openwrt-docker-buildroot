FROM debian:12

# Change openwrt-tag here or use args during build or git checkout in the container
ARG OPENWRT_TAG=v24.10.1

# install dependencies
RUN apt-get update \
    && apt-get install -y \
            build-essential \
            file \
            gawk \
            gettext \
            git \
            libncurses-dev \
            libssl-dev \
            python3 \
            python3-distutils \
            python3-setuptools \
            rsync \
            swig \
            unzip \
            wget \
            xsltproc \
            zlib1g-dev \
    && apt-get clean

RUN useradd -ms /bin/bash openwrt
USER openwrt

RUN git clone --depth 1 --branch ${OPENWRT_TAG} git://git.openwrt.org/openwrt/openwrt.git /home/openwrt/build

RUN mkdir /home/openwrt/build/bin/ \
    && mkdir /home/openwrt/build/files/

WORKDIR /home/openwrt/build/

RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

VOLUME /home/openwrt/build/bin/
VOLUME /home/openwrt/build/files/
