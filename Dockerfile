FROM brimstone/debian:sid

RUN package build-essential libssl-dev libncurses5-dev unzip gawk zlib1g-dev \
            git subversion mercurial gettext file python wget

RUN git clone --recursive https://git.lede-project.org/source.git /build \
 && useradd build -M -d /build \
 && chown -R build: /build

WORKDIR /build

USER build

COPY oldconfig /build/.config

RUN ./scripts/feeds update -a \
 && ./scripts/feeds install -a \
 && make oldconfig \
 && make
