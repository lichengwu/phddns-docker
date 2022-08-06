# 花生壳Linux docker版本

目前已更新到最新版本 5.2.0

## 使用方法

### docker 命令行

> mac地址自己替换下，随机生成或者用自己的物理网卡地址都可以，避免冲突
```shell
docker run --name phddns --privileged -d  --mac-address AA:BB:CC:DD:EE:FF  olbeta/phddns
```

### docker-compose 文件
 
1.创建 **docker-compose** 文件 
```
version: "3"
services:

    phddns:
        image: olbeta/phddns
        container_name: phddns
        restart: always
        mac_address: AA-BB-CC-DD-EE-FF
```

## 查看 **SN**

>  可以直接运行 `docker logs -f phddns` 进行查看 

>  可以直接运行 `docker exec -it phddns phddns status` 进行查看

> 使用 *docker-compose* 的用户可以直接运行 `docker-compose logs -f phddns` 进行查看
1. 进入docker容器
```shell
docker exec -it phddns /bin/bash
```
2. 在docker容器查看花生壳SN
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


3. 去 http://b.oray.com 登录绑定，密码默认admin 

如遇安装问题，可以参考官方教程：https://service.oray.com/question/11630.html

## 重置方法

运行 `docker exec -it phddns phddns reset` 进行重置

## 支持指令

    phddns  start|status|stop|restart|reset|enable|disable|version