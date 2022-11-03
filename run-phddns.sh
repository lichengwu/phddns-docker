#!/bin/bash

SF_NAME="$0"

LOG_INFO() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] - [${SF_NAME}] - \033[0;32m[INFO]: $* \033[0m"
}

LOG_ERROR() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] - [${SF_NAME}] - \033[0;31m[ERROR]: $* \033[0m"
}

LOG_WARNING() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] - [${SF_NAME}] - \033[0;33m[WARNING]: $* \033[0m"
}

LOG_RUN() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] - [${SF_NAME}] - \033[43;34m[RUN]: $@\033[0m"
    eval $@
}

if [[ ! -f /usr/bin/phddns ]]; then
    echo $(LOG_WARNING "安装 phddns") >>/var/log/phddns/phtunnel.log
    wget --no-check-certificate -q https://down.oray.com/hsk/linux/phddns_5.2.0_amd64.deb -o /tmp/phddns_5.2.0_amd64.deb
    dpkg -i /tmp/phddns_5.2.0_amd64.deb
    rm /tmp/phddns_5.2.0_amd64.deb
    cp /usr/bin/phdaemon /usr/bin/phdaemon.bak
fi

cp /usr/bin/phdaemon.bak /usr/bin/phdaemon
sed -i "s|127.0.0.1|${LOG_HTTP_IP}|g" /usr/bin/phdaemon
sed -i "s|11011|${LOG_HTTP_PORT}|g" /usr/bin/phdaemon
echo $(LOG_INFO "【网络日志监听】 [${LOG_HTTP_IP}:${LOG_HTTP_PORT}]") >>/var/log/phddns/phtunnel.log

echo $(LOG_INFO "【开始启动】 [starting]") >>/var/log/phddns/phtunnel.log
phddns restart

while true; do
    sleep 1
    rpcport=$(netstat -anp | grep 16062)
    if [ -z "$rpcport" ]; then
        echo $(LOG_INFO "【等待启动】") >>/var/log/phddns/phtunnel.log
        continue
    else
        echo $(LOG_INFO "【启动成功】") >>/var/log/phddns/phtunnel.log
        break
    fi
done

phddns status
