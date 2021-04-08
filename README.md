# 花生壳Linux docker版本

## 使用方法

1. 运行docker
```shell
docker run --name phddns --privileged -d  --mac-address 80:0C:E7:81:B0:04  olbeta/phddns
```
2. 进入docker容器
```shell
docker exec -it phddns /bin/bash
```
3. 在docker容器查看花生壳SN
```shell
phddns status
 +--------------------------------------------------+
 |          Oray PeanutHull Linux 5.1.0             |
 +--------------------------------------------------+
 |              Runstatus: ONLINE                   |
 +--------------------------------------------------+
 |              SN: xxxxxxxxxxxxxxxx                |
 +--------------------------------------------------+
 |    Remote Management Address http://b.oray.com   |
 +--------------------------------------------------+

```
4. 去http://b.oray.com登录绑定，密码默认admin

