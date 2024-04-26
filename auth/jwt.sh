# Create RSA Private Key
openssl genpkey -algorithm RSA -out private_key.pem
# Extract public key from private key
openssl rsa -pubout -in private_key.pem -out public_key.pem
# Install JWT utility
# https://github.com/mike-engel/jwt-cli
# On Mac
# brew install mike-engel/jwt-cli/jwt-cli
# Generate JWT token
JWT_TOKEN=$(jwt encode \
    --alg RS256 \
    --secret @private_key.pem \
    '{"iss": "vault-support-issuer","sub": "vault-support-subject"}' \
)
# Enable the JWT auth method
vault auth enable jwt
# Configure the JWT auth method to validate using the RSA public key
vault write auth/jwt/config jwt_validation_pubkeys=@public_key.pem
# Create the JWT role to validate against the subject (sub) claim for the JWT token
vault write auth/jwt/role/test-role role_type=jwt user_claim=sub bound_subject=vault-support-subject
# Login with JWT token
vault write auth/jwt/login role=test-role jwt=$JWT_TOKEN