# 国内网络问题

[![](https://img.shields.io/badge/AD-%E8%85%BE%E8%AE%AF%E4%BA%91%E5%AE%B9%E5%99%A8%E6%9C%8D%E5%8A%A1-blue.svg)](https://cloud.tencent.com/redirect.php?redirect=10058&cps_key=3a5255852d5db99dcd5da4c72f05df61) [![](https://img.shields.io/badge/Support-%E8%85%BE%E8%AE%AF%E4%BA%91%E8%87%AA%E5%AA%92%E4%BD%93-brightgreen.svg)](https://cloud.tencent.com/developer/support-plan?invite_code=13vokmlse8afh)

* 从 `GitHub` 下载文件（docker-compose、composer）

> 可以尝试自定义 [hosts](https://github.com/khs1994-docker/lnmp/blob/master/config/etc/hosts)

* 官方默认的 `apt` 镜像

* `pecl`

* PHP `composer`

* Alpine apk https://mirrors.alpinelinux.org/

解决思路：

镜像构建尽可能使用 CI 服务器，国内云服务商均免费提供国外的容器构建环境。

在 `Dockerfile` 中，将 URL(国内访问慢的地址，例如 PHP 源码下载地址) 设置为 `ENV` 或 `ARG` 其默认值为官方地址。

本地测试（国内）时，使用 `Docker compose` 通过 `ARG` 将 URL 设为国内镜像地址。

具体参考本项目的 PHP compose 文件 https://github.com/khs1994-docker/lnmp/blob/master/dockerfile/php/docker-compose.yml

## `LNMP_CN_ENV` 环境变量

本项目会根据 `LNMP_CN_ENV=true` (默认，无需添加环境变量) 来替换源为国内镜像，避免因网络问题影响使用（当你的环境处于非国内环境时请设置为 `LNMP_CN_ENV=false`）。

## 部分镜像支持国内镜像

> 由于国内仓库配额有限，较旧的镜像会被自动清理，这时请使用原始镜像，如何使用请参考 [自定义](custom.md)

* `khs1994/php`           => `ccr.ccs.tencentyun.com/khs1994/php`
* `nginx`                 => `ccr.ccs.tencentyun.com/khs1994/nginx`
* `mysql`                 => `ccr.ccs.tencentyun.com/khs1994/mysql`
* `redis`                 => `ccr.ccs.tencentyun.com/khs1994/redis`
* `memcached`             => `ccr.ccs.tencentyun.com/khs1994/memcached`
* `phpmyadmin/phpmyadmin` => `ccr.ccs.tencentyun.com/khs1994/phpmyadmin`
* `rabbitmq`              => `ccr.ccs.tencentyun.com/khs1994/rabbitmq`
* `postgres`              => `ccr.ccs.tencentyun.com/khs1994/postgres`
* `mongo`                 => `ccr.ccs.tencentyun.com/khs1994/mongo`
* `minio`                 => `ccr.ccs.tencentyun.com/khs1994/minio`
* `httpd`                 => `ccr.ccs.tencentyun.com/khs1994/httpd`
* `registry`              => `ccr.ccs.tencentyun.com/khs1994/registry`
* `mariadb`               => `ccr.ccs.tencentyun.com/khs1994/mariadb`
* `kong`                  => `ccr.ccs.tencentyun.com/khs1994/kong`
