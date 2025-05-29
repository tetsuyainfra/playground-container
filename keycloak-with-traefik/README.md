

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
