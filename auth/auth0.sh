### Not Scripted ###
# Sign up for Auth0 and get the following values for setup
export AUTH0_DOMAIN="aaaaaaaaa"
export AUTH0_CLIENT_ID=""
export AUTH0_CLIENT_SECRET=""
# Add the following URLs into the "Allowed Callback URLs"
# https://localhost:8250/oidc/callback, ttps://localhost:8200/ui/vault/auth/oidc/oidc/callback
####################

vault policy write reader - <<EOF
# Read permission on the k/v secrets
path "*" {
    capabilities = ["read", "list"]
}
EOF

# Enable and configure oidc auth method
vault auth enable oidc
vault write auth/oidc/config \
         oidc_discovery_url="https://$AUTH0_DOMAIN/" \
         oidc_client_id="$AUTH0_CLIENT_ID" \
         oidc_client_secret="$AUTH0_CLIENT_SECRET" \
         default_role="reader"
vault write auth/oidc/role/reader \
      bound_audiences="$AUTH0_CLIENT_ID" \
      allowed_redirect_uris="http://localhost:8200/ui/vault/auth/oidc/oidc/callback" \
      allowed_redirect_uris="http://localhost:8250/oidc/callback" \
      allowed_redirect_uris="http://max.com:8250/oidc/callback" \
      allowed_redirect_uris="https://max.com:8259/oidc/callback" \
      user_claim="sub" \
      verbose_oidc_logging=true \
      policies="admin"

vault write auth/oidc/role/reader -<<EOF
{
    "bound_claims": { "foo": ["bar"] }
}
EOF

vault read auth/oidc/role/reader

# Login with the new auth method
vault login -method=oidc role="reader"

