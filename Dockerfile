FROM ubuntu

ENV TZ Asia/Shanghai

ENV DEBIAN_FRONTEND noninteractive

ENV ORAY_HOME /usr/local/oray

RUN mkdir -p ${ORAY_HOME}

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y net-tools psmisc supervisor wget bash-completion # 增强补全功能

WORKDIR /tmp

ADD "https://down.oray.com/hsk/linux/phddns_5.2.0_amd64.deb" /tmp/phddns_5.2.0_amd64.deb

RUN dpkg -i /tmp/phddns_5.2.0_amd64.deb && rm /tmp/phddns_5.2.0_amd64.deb

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt autoclean

EXPOSE 6060

CMD ["/usr/bin/supervisord"]
