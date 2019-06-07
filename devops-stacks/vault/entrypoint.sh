#!/bin/bash 

vault server -config /vault/config/vault.json &

while [ ! -e  /var/run/vault.pidfile ]; do sleep 1; done
while [ -z "$(netstat -natpl | grep $(cat /var/run/vault.pidfile)/vault | grep LISTEN)" ]; do sleep 1; echo 1; done

export VAULT_FILE=/vault/file

if [ ! -e ${VAULT_FILE}/unseal.key ]; then
    vault operator init -key-shares=1 -key-threshold=1 > ${VAULT_FILE}/init.data
    grep 'Unseal Key' ${VAULT_FILE}/init.data | awk -F' ' '{print $4}' > ${VAULT_FILE}/unseal.key
    grep 'Initial Root Token' ${VAULT_FILE}/init.data | awk -F' ' '{print $4}' > ${VAULT_FILE}/root.key
fi

if [ "$(vault status | grep Sealed | awk '{print $2}')" == "true" ]; then
	echo
    vault operator unseal $(cat ${VAULT_FILE}/unseal.key) | grep Sealed
fi

vault login $(cat ${VAULT_FILE}/root.key) >/dev/null
vault token lookup ${TOKEN} 2>&1 >/dev/null

if [ $? -ne 0 ] ; then
    vault login $(cat ${VAULT_FILE}/root.key)
    vault token create -policy=root -display-name=admin -id=${TOKEN}
fi

echo
echo Vault is OK
echo 

while [ -e  /var/run/vault.pidfile ]; do
    sleep 1;
done
