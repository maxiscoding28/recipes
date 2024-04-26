curl \
   --request POST \
   --data '{"jwt": "<your service account jwt>", "role": "demo"}' \
   http://127.0.0.1:8200/v1/auth/kubernetes/login


