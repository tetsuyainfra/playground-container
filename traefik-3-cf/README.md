# dashboardだけ別ポートに設定してみる

# HOWTO
```shell


$ docker compose up

# SEE
# http://localhost.docker.internal/
# -> 404
# http://localhost.docker.internal:8080
# /dashboardへ302して表示できる
```

# 参考
- https://zenn.dev/pitekusu/books/traefik-pitekusu