FROM ubuntu:16.04

ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

ENV ORAY_HOME /usr/local/oray
RUN mkdir -p ${ORAY_HOME}
ADD sources.list /etc/apt/sources.list
RUN apt update
RUN apt install -y  wget net-tools
RUN mkdir -p /tmp/
ADD phddns_5_1_amd64.deb /tmp/hddns.deb
RUN dpkg -i /tmp/hddns.deb && rm /tmp/hddns.deb
RUN apt-get install -y supervisor
ADD supervisord.conf /supervisord.conf
COPY /supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN apt autoclean

EXPOSE 6060

CMD ["/usr/bin/supervisord"]
