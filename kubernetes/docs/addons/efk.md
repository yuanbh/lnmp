# EFK 插件

## 注意事项

* 推荐宿主机内存 16G

* 虚拟机每个节点内存分配 3G，之前分配了 2G 一直报错

* es-statefulset.yaml 的 replicas 参数 **不能** 为 1 **故单集群不能用**

## 资源占用

`elasticsearch-logging-N` 单个 pod 内存占用 1.5 G。

## 基础知识

* elasticsearch 负责存储日志。

* fluentd 负责将集群中 docker 主机上的日志发送给 elasticsearch，因此 fluentd 在 k8s 集群中需要以 daemonset 的方式运行。

* kibana 负责图形化展示日志信息。

## 部署

* https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch

### 部署

```bash
$ kubectl apply -k addons/efk

$ kubectl get pods -n kube-system -o wide|grep -E 'elasticsearch|fluentd|kibana'

$ kubectl cluster-info|grep -E 'Elasticsearch|Kibana'

$ kubectl proxy --address='192.168.57.1' --port=8086 --accept-hosts='^*$'
```

http://192.168.57.1:8086/api/v1/namespaces/kube-system/services/kibana-logging/proxy

## 删除

```bash
$ kubectl delete -k addons/efk
```

## 资源列表

```bash
service/elasticsearch-logging

service/kibana-logging

daemonset.apps/fluentd
```

## More Information

* http://blog.51cto.com/ylw6006/2071943
* https://www.jianshu.com/p/1000ae80a493
* https://blog.csdn.net/java_zyq/article/details/82179175
