# Hashicorp Vault

## Start the Stack

```
$ docker-compose up -d
```

## Browsing Vault UI

[http://localhost:8200/ui](http://localhost:8200/ui)

## Vault Operations

```
export VAULT_ADDR=http://localhost:8200
vault login root
vault secrets enable -path=testing kv

vault write testing/service-user foo=bar
vault read testing/service-user -format=json
vault read testing/service-user -format=yaml
```