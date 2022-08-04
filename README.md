# 花生壳Linux docker版本

目前已更新到最新版本 5.2.0

## 使用方法

1. 运行docker，mac地址自己替换下，随机生成或者用自己的物理网卡地址都可以，避免冲突
```shell
docker run --name phddns --privileged -d  --mac-address AA:BB:CC:DD:EE:FF  olbeta/phddns
```
2. 进入docker容器
```shell
docker exec -it phddns /bin/bash
```
3. 在docker容器查看花生壳SN
```shell
phddns status
 +--------------------------------------------------+
 |          Oray PeanutHull Linux 5.2.0             |
 +--------------------------------------------------+
 |              Runstatus: ONLINE                   |
 +--------------------------------------------------+
 |              SN: xxxxxxxxxxxxxxxx                |
 +--------------------------------------------------+
 |    Remote Management Address http://b.oray.com   |
 +--------------------------------------------------+
```
> 可以直接运行 `docker exec -it phddns phddns status` 进行查看

4. 去 http://b.oray.com 登录绑定，密码默认admin 

如遇安装问题，可以参考官方教程：https://service.oray.com/question/11630.html

## 重置方法

运行 `docker exec -it phddns phddns reset` 进行重置

## 支持指令

    phddns  start|status|stop|restart|reset|enable|disable|version