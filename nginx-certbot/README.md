

HOWTO
```shell
# 1. standaloneモードで certbot を動かす
#    その際、80番を開放しておく
docker compose run --rm -it --publish 80:80  --entrypoint /usr/local/bin/certbot certbot certonly -d hoge.example.com --standalone 
# Saving debug log to /var/log/letsencrypt/letsencrypt.log
# Enter email address or hit Enter to skip.
#  (Enter 'c' to cancel):

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Please read the Terms of Service at:
# https://letsencrypt.org/documents/LE-SA-v1.5-February-24-2025.pdf
# You must agree in order to register with the ACME server. Do you agree?
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# (Y)es/(N)o: Y
# Account registered.
# Requesting a certificate for hoge.example.com

# Successfully received certificate.
# Certificate is saved at: /etc/letsencrypt/live/hoge.example.com/fullchain.pem
# Key is saved at:         /etc/letsencrypt/live/hoge.example.com/privkey.pem
# This certificate expires on 2025-08-26.
# These files will be updated when the certificate renews.

# NEXT STEPS:
# - The certificate will need to be renewed before it expires. Certbot can automatically renew the certificate in the background, but you may need to take steps to enable that functionality. See https://certbot.org/renewal-setup for instructions.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# If you like Certbot, please consider supporting our work by:
#  * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
#  * Donating to EFF:                    https://eff.org/donate-le
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# 2. 証明書が出来ているか確認する
$ docker volume ls 
DRIVER    VOLUME NAME
local     nginx_certs   <-- これ
local     nginx_webroot
$ docker run --rm -v nginx_certs:/certs ubuntu /bin/bash -c 'ls -l /certs/live/hoge.example.com'
$ docker run --rm -v nginx_certs:/certs ubuntu /bin/bash -c 'cat /certs/renew/hoge.example.com.conf'

# 3.1 nginx を service として起動する
docker compose up nginx

# 3.2 certbot の設定を変更して起動する
docker compose run --rm -it  --entrypoint /usr/local/bin/certbot certbot certonly -d hoge.example.com --webroot --webroot-path /opt/webroot

# 4. certbot を service として起動する
docker compose up certbot
```


MEMO:
  - certbot standalone modeを使って初期化したほうがよくないか？
  - docker network で ipv6を使う
    - https://docs.docker.com/engine/daemon/ipv6/
    - 専用ネットワークを作る
    - daemon.json で ipv6: trueをする
  - traefik使った方がよさそう
  - TLS: CNがどう扱われるのかよくわからない問題
    - https://qiita.com/jqtype/items/bd6f0d819944ef954d88
    - cloudflareのTLS/SSL proxyを使った時もどうなるかわからない問題

