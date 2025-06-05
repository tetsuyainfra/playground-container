

#  HOW TO RUN
see original document
https://docs.goauthentik.io/docs/install-config/install/docker-compose
```shell

echo "PG_PASS=$(openssl rand -base64 36 | tr -d '\n')" >> .env
echo "AUTHENTIK_SECRET_KEY=$(openssl rand -base64 60 | tr -d '\n')" >> .env

# docker compose pull
# docker compose up -d
# or
./compose up

# open in browser(needs last slash)
http://localhost:9000/if/flow/initial-setup/A




# after config authentik
cd express-auth-example
npm exec auth secret
```
