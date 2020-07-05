# Endpoints 将外部服务映射到 K8s

* https://blog.csdn.net/liyingke112/article/details/76204038

```yaml
apiVersion: v1
kind: Service
metadata:
  name: lykops
spec:
  ports:
  - port: 80
    targetPort: 81
    protocol: TCP
---
apiVersion: v1
kind: Endpoints
metadata:
  name: lykops
subsets:
  - addresses:
    - ip: 172.17.241.47
    - ip: 59.107.26.221
    ports:
    - port: 80
      protocol: TCP
```
