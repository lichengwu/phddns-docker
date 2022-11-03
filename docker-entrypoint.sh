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
if [[ $* == 'phddns start' ]]; then
    echo $(LOG_INFO "phddns start") >>/var/log/phddns/phtunnel.log
    /app/run-phddns.sh &
    
    tail -q -n 0 -f /var/log/phddns/phtunnel.log
    echo $(LOG_INFO "结束运行") >>/var/log/phddns/phtunnel.log
    
fi

exec "$@"
