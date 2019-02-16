FROM alpine:3.6

ENV LOCAL_ADDR      127.0.0.1
ENV LOCAL_PORT      1090
ENV SERVER_ADDR     137.116.147.80
ENV SERVER_PORT     19007
ENV PASSWORD        hiaewalle
ENV METHOD          chacha20-ietf
ENV PROTOCOL        auth_chain_a
ENV PROTOCOLPARAM   32
ENV OBFS            tls1.2_ticket_auth
ENV OBFSPARAM       obfsparam
ENV TIMEOUT         300
ENV DNS_ADDR        8.8.8.8
ENV DNS_ADDR_2      8.8.4.4

ARG BRANCH=manyuser
ARG WORK=/opt/shadowsocksr

RUN apk --no-cache add python \
    libsodium \
    wget

RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/shadowsocksrr/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK

WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks

EXPOSE $LOCAL_PORT
CMD python local.py -s $SERVER_ADDR -p $SERVER_PORT -b $LOCAL_ADDR -l $LOCAL_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -g $OBFSPARAM -G $PROTOCOLPARAM
