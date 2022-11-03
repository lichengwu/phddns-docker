# 花生壳Linux docker版本

目前已更新到版本 5.2.0

官方网页 <https://hsk.oray.com/>

## 使用方法

### docker 命令行

- mac地址自己替换下，随机生成或者用自己的物理网卡地址都可以，避免冲突

```shell
docker run --name phddns -d  --mac-address AA:BB:CC:DD:EE:FF olbeta/phddns
```

- 如需指定网络模式为host请添加参数 `--network=host`

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
        # network_mode: host
```

## 查看 **SN**

- 可以直接运行 `docker logs -f phddns` 进行查看

- 可以直接运行 `docker exec -it phddns phddns status` 进行查看

- 使用 *docker-compose* 的用户可以直接运行 `docker-compose logs -f phddns` 进行查看

## 绑定账号

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

- 去 <http://b.oray.com> 登录绑定，密码默认admin

如遇安装问题，可以参考官方教程：<https://service.oray.com/question/11630.html>

## 重置方法

运行 `docker exec -it phddns phddns reset` 进行重置

## 支持指令

```shell
    phddns  start|status|stop|restart|reset|enable|disable|version
```

## 日志查看

### docker

### http

- 设置环境变量  `LOG_HTTP_PORT=11011` `LOG_HTTP_IP='0.0.0.0'` `127.0.0.1` `192.168.1.100`
- 网络非 `host` 模式映射端口 `11011` `--network=host` `network_mode: host`
- 访问 `host:port/phtunnel_control/phtunnel_cgi`

```shell
        -e LOG_HTTP_IP='0.0.0.0' -e LOG_HTTP_PORT=11011 -p 11011:11011
```

```yaml
        environment:
            - LOG_HTTP_IP='127.0.0.1' # 换成你想监听的地址
            - LOG_HTTP_PORT=11011
        network_mode: host
        # ports:
        #     - 8080:11011
```

### 自行编译

1. 配置环境变量 `REGISTRY` *可选*
    - Windows `$env:registry.your.domain`
    - Linux `export REGISTRY=docker.io`
2. 指定文件编译 `docker compose -f .\docker-compose.build.yaml build`
3. 推送到镜像服务器 `docker compose -f .\docker-compose.build.yaml push` *可选*
4. 修改 `docker-compose.yaml`
5. 后台运行 `docker compose up -d`

> 你也可以直接修改 `docker-compose.yaml` 编译运行
