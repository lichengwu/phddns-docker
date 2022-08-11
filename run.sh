#!/bin/bash

: > /var/log/phddns/*.log

echo "[$(date "+%Y-%m-%d %H:%M:%S")][INFO] [run.sh]: 【开始启动】 docker container start" >> /var/log/phddns/phtunnel.log

phddns start

sleep 2

phddns status

tail -f /var/log/phddns/*.log