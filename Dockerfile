FROM ubuntu

ARG name="phddns"
ARG summary="花生壳 Linux x86_64 docker 版本"
LABEL description="${summary}" \
    maintainer="<ol_l@msn.cn>" \
    app.kubernetes.io/name="${name}" \
    org.opencontainers.image.title="${name}" \
    org.opencontainers.artifact.description="${summary}" \
    org.opencontainers.image.url="hhttps://hub.docker.com/r/olbeta/phddns" \
    org.opencontainers.image.source="https://github.com/lichengwu/phddns-docker" \
    org.opencontainers.image.authors="<ol_l@msn.cn>" \
    org.opencontainers.image.description="${summary}" \
    org.opencontainers.image.licenses="https://hsk.oray.com/"

ENV TZ Asia/Shanghai


ENV ORAY_HOME /usr/local/oray
RUN mkdir -p ${ORAY_HOME}

ARG DEBIAN_FRONTEND noninteractive
# RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN apt-get update

# 设置时区
RUN apt-get install -y apt-utils tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y wget curl net-tools psmisc lsb-release bash-completion # 增强补全功能

RUN apt-get autoclean


WORKDIR /tmp
ADD "https://down.oray.com/hsk/linux/phddns_5.2.0_amd64.deb" /tmp/phddns_5.2.0_amd64.deb

RUN dpkg -i /tmp/phddns_5.2.0_amd64.deb && rm /tmp/phddns_5.2.0_amd64.deb
RUN rm /etc/phtunnel.json
RUN cp /usr/bin/phdaemon /usr/bin/phdaemon.bak
WORKDIR /app/
COPY *.sh /app/
RUN chmod +x /app/*.sh

ENV LOG_HTTP_IP '127.0.0.1'
ENV LOG_HTTP_PORT '11011'

RUN    mkdir -p /var/log/phddns/
RUN    touch /var/log/phddns/phtunnel.log
ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["phddns", "start"]

