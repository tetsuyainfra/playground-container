
# カスタマイズの情報
[開発者ガイド](https://www.keycloak.org/docs/latest/server_development/)
[Keycloak Quickstarts](https://github.com/keycloak/keycloak-quickstarts)


how to create devcontainer config
```shell
# 1. VSCodeの左下（ギアマークより下の部分）をクリックし 新しい開発コンテナの構成を～をクリック
# 1.1 java + postgresql を選択
# 1.2 ToolにMavenを選択

# MEMO: miseがfeaturesでインストールできなかった。のでDockerfileに記入してインストール
# コンテナ内、vscodeのユーザ等はDocerfileのbuild後に入れるみたいなので、postCreateCommandで対処
#"features": {
#	"ghcr.io/devcontainers-extra/features/mise:1": {},
#},
# と思ったら、Dockerfileのベースイメージを変更(bullseye -> bookwromへ)したら動いた
# FROM mcr.microsoft.com/devcontainers/java:1-21-bookworm
```



# Realmの保存方法
```
$ ./compose.sh stop auth
$ ./compose.sh --rm -it --entrypoint /bin/bash auth 
#in auth container
$ cd /opt/keycloak
$ ./bin/kc.sh export --dir /tmp/realmtmp --users different_files
# see help
$ ./bin/kc.sh export --help

```


# comopse.ymlでの環境変数
  - compose.yml と同じディレクトリにある.evn
    - compose.ymlで使える環境変数
  - envitonment:
    - container内の環境変数
  - env_file:
    - container内の環境変数
  - docker compose config で確認できる
