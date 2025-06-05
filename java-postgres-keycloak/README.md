
# カスタマイズの情報
[開発者ガイド](https://www.keycloak.org/docs/latest/server_development/)
[Keycloak Quickstarts](https://github.com/keycloak/keycloak-quickstarts)
[Authentication Flow](https://www.keycloak.org/docs/26.2.5/server_admin/#_authentication-flows)
[github.com/inventage/keycloak-custom](https://github.com/inventage/keycloak-custom)
[↑の情報](https://keycloak.ch/keycloak-tutorials/tutorial-custom-keycloak/)

# やりたいこと
- Userのカスタムバリューhttps://www.google.co.jp/
- UserのIDをゲット
  - User Propertyのmapperでできそう。OAuth client側で設定が必要？
  - mapperの確認はclient毎のclient scopes -> evaluateで確認可能
  - auth.jsの設定でprofileに入っているのを確認
    ```
    Keycloak({
      async profile(profile) {
        console.log("profile: ", profile);
        return profile;
      },
    })
    ~~~
- 認証フロー(Authentication Flow)をKeycloakとclient appで変える → Keycloakデフォルトフローとclientが使うデフォルトフローを変更する
- 利用できそうな仕組み
  - Consent Screen(同意画面)の有効化 -> Clients -> 個々のクライアント ->  Setting(Login settings) -> Consent required , Display client screenを有効化
    - Grant Access to clientdemo の画面にUser名とか表示させたい
      - mytheme/login/consent.ftlのカスタマイズで可能
        - client毎のLogin themeでカスタマイズ
      - https://github.com/keycloak/keycloak/blob/a66f7fbc53d742ebf049e47c05075a4c79f273da/services/src/main/java/org/keycloak/forms/login/freemarker/FreeMarkerLoginFormsProvider.java#L313
        - ここに  attributes.put("user", new ProfileBean(idpCtx, formData)); を追加すればアクセスできるのではないか？
    - 作成したextensionはここにおいておけば自動で読み込んでくれるっぽい
      ```
      bash-5.1$ ls /opt/keycloak/providers
      custom-login-forms-provider-1.0-SNAPSHOT.jar  README.md
      ```


- 僕が考えたフロー
    - Cookieを読み込んでログインしているUsernameを出す
    - Passowrdを書き込む
    - login成功

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
