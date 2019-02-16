FROM alpine:3.6

ENV LOCAL_ADDR      0.0.0.0
ENV LOCAL_PORT      1090
ENV SERVER_ADDR     13.76.46.29
ENV SERVER_PORT     2333
ENV PASSWORD        hiaewalle
ENV METHOD          AES-256-CFB
ENV PROTOCOL        auth_aes128_md5
ENV PROTOCOLPARAM   
ENV OBFS            tls1.2_ticket_auth
ENV OBFSPARAM       
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
