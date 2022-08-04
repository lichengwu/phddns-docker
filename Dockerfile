FROM ubuntu

ENV TZ Asia/Shanghai

ENV DEBIAN_FRONTEND noninteractive

ENV ORAY_HOME /usr/local/oray

RUN mkdir -p ${ORAY_HOME}

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update

# 设置时区
RUN apt-get install -y apt-utils tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y net-tools psmisc wget bash-completion # 增强补全功能

RUN apt-get autoclean

WORKDIR /tmp

ADD "https://down.oray.com/hsk/linux/phddns_5.2.0_amd64.deb" /tmp/phddns_5.2.0_amd64.deb

RUN dpkg -i /tmp/phddns_5.2.0_amd64.deb && rm /tmp/phddns_5.2.0_amd64.deb


WORKDIR /opt/phddns/

ADD run.sh /opt/phddns/run.sh

RUN chmod +x /opt/phddns/run.sh


EXPOSE 6060

CMD ["/opt/phddns/run.sh"]
