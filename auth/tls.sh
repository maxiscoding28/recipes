# tls auth
export VAULT_ADDR=$VAULT_ADDR:8200

export VAULT_CACERT="$PATH_TO_CA_CERT"

vault login $TOKEN

vault auth enable cert

vault write auth/cert/certs/test certificate=@$PATH_TO_CERT