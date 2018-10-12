FROM alpine:3.6

ARG BRANCH=manyuser
ARG WORK=~

RUN apk --no-cache add python \
    libsodium \
    wget \
    proxychains-ng

RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksrr/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK

WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks

VOLUME /confs

CMD proxychains -q -f /confs/proxychains.conf python local.py -c /confs/config.json
